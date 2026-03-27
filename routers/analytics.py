from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import func
from datetime import datetime, timedelta
from collections import Counter

from database import get_db
from models import MeditationSession, CheckIn, EmotionLog

router = APIRouter(prefix="/analytics", tags=["Analytics"])


# ================= PROGRESS ANALYTICS =================
@router.get("/progress/{user_id}")
def progress_analytics(user_id: int, period: str = "day", db: Session = Depends(get_db)):

    now = datetime.utcnow()

    if period == "day":
        start_date = now.replace(hour=0, minute=0, second=0, microsecond=0)
    elif period == "week":
        start_date = now - timedelta(days=7)
    elif period == "month":
        start_date = now - timedelta(days=30)
    else:
        start_date = now - timedelta(days=1)

    sessions = db.query(MeditationSession).filter(
        MeditationSession.user_id == user_id,
        MeditationSession.status == "completed",
        MeditationSession.completed_at >= start_date   # ← FIXED: was end_time
    ).all()

    mindful_minutes = sum(s.duration or 0 for s in sessions)

    checkins = db.query(CheckIn).filter(
        CheckIn.user_id == user_id,
        CheckIn.created_at >= start_date
    ).all()

    if checkins:
        avg_mood = sum(c.mood_score for c in checkins) / len(checkins)
        calm_score = int(avg_mood * 10)
    else:
        calm_score = 0

    stress_reduced = min(int(mindful_minutes * 0.5), 100)

    return {
        "period": period,
        "calm_score": calm_score,
        "mindful_minutes": mindful_minutes,
        "stress_reduced": stress_reduced
    }


# ================= EMOTIONAL TREND GRAPH =================
@router.get("/emotion-trend/{user_id}")
def emotion_trend(user_id: int, period: str = "week", db: Session = Depends(get_db)):

    now = datetime.utcnow()

    if period == "day":
        start_date = now - timedelta(days=1)
    elif period == "week":
        start_date = now - timedelta(days=7)
    else:
        start_date = now - timedelta(days=30)

    checkins = db.query(CheckIn).filter(
        CheckIn.user_id == user_id,
        CheckIn.created_at >= start_date
    ).order_by(CheckIn.created_at.asc()).all()

    return [
        {
            "date": c.created_at.strftime("%Y-%m-%d"),
            "score": c.mood_score
        }
        for c in checkins
    ]


# ================= SESSION COMPLETION MAP =================
@router.get("/completion/{user_id}")
def completion_map(user_id: int, db: Session = Depends(get_db)):

    today = datetime.utcnow().date()
    week_start = today - timedelta(days=today.weekday())

    sessions = db.query(MeditationSession).filter(
        MeditationSession.user_id == user_id,
        MeditationSession.status == "completed"
    ).all()

    completion = {i: 0 for i in range(7)}

    for s in sessions:
        if s.completed_at:                                      # ← FIXED: was end_time
            diff = (s.completed_at.date() - week_start).days   # ← FIXED: was end_time
            if 0 <= diff < 7:
                completion[diff] += 1

    return completion


# ================= MOOD HISTORY =================
@router.get("/mood-history/{user_id}")
def mood_history(user_id: int, db: Session = Depends(get_db)):

    checkins = db.query(CheckIn).filter(
        CheckIn.user_id == user_id
    ).order_by(CheckIn.created_at.desc()).limit(7).all()

    print("MOOD HISTORY DATA:", checkins)  # 🔥 DEBUG

    return {
        "status": "success",
        "history": [
            {
                "mood": c.mood_score,
                "date": str(c.created_at)
            }
            for c in checkins
        ]
    }
# ================= MOOD TREND =================
@router.get("/mood-trend/{user_id}")
def mood_trend(user_id: int, db: Session = Depends(get_db)):
    checkins = db.query(CheckIn).filter(
        CheckIn.user_id == user_id
    ).order_by(CheckIn.created_at.desc()).limit(7).all()

    return {
        "status": "success",
        "trend": [
            {"score": c.mood_score, "date": str(c.created_at)}
            for c in checkins
        ]
    }


# ================= WEEKLY COMPLETION =================
@router.get("/weekly-completion/{user_id}")
def weekly_completion(user_id: int, db: Session = Depends(get_db)):
    week_ago = datetime.utcnow() - timedelta(days=7)
    sessions = db.query(MeditationSession).filter(
        MeditationSession.user_id == user_id,
        MeditationSession.status == "completed",
        MeditationSession.completed_at >= week_ago
    ).all()

    return {
        "status": "success",
        "completed_this_week": len(sessions),
        "total_minutes": sum(s.duration or 0 for s in sessions)
    }


# ================= SUMMARY =================
@router.get("/summary/{user_id}")
def analytics_summary(user_id: int, db: Session = Depends(get_db)):
    all_sessions = db.query(MeditationSession).filter(
        MeditationSession.user_id == user_id,
        MeditationSession.status == "completed"
    ).all()

    total_mins = sum(s.duration or 0 for s in all_sessions)

    checkins = db.query(CheckIn).filter(
        CheckIn.user_id == user_id
    ).order_by(CheckIn.created_at.desc()).limit(7).all()

    calm_score = (
        int(sum(c.mood_score for c in checkins) / len(checkins) * 10)
        if checkins else 0
    )

    return {
        "status": "success",
        "total_sessions": len(all_sessions),
        "total_minutes": total_mins,
        "calm_score": calm_score,
        "stress_reduced": min(int(total_mins * 0.5), 100)
    }


# ================= AI MOOD PREDICTION (NEW FEATURE 1) =================
@router.get("/mood-prediction/{user_id}")
def predict_mood(user_id: int, db: Session = Depends(get_db)):
    """
    Predicts tomorrow's mood based on user's emotion log history.
    Uses day-of-week pattern: finds what mood the user usually
    feels on the same weekday as tomorrow.
    Requires at least 3 emotion logs to activate.
    """
    logs = db.query(EmotionLog).filter(
        EmotionLog.user_id == user_id
    ).order_by(EmotionLog.created_at.desc()).limit(30).all()

    if len(logs) < 3:
        return {
            "status": "insufficient_data",
            "predicted_mood": None,
            "recommended_session": None,
            "message": "Log your mood for a few more days to unlock predictions"
        }

    # Tomorrow's day of week (0=Monday ... 6=Sunday)
    tomorrow_dow = (datetime.utcnow().weekday() + 1) % 7

    # Moods logged on the same weekday historically
    same_day_moods = [
        log.mood.lower() for log in logs
        if log.created_at.weekday() == tomorrow_dow
    ]

    # Fall back to most recent 7 logs if not enough same-day data
    if len(same_day_moods) < 2:
        same_day_moods = [log.mood.lower() for log in logs[:7]]

    # Most common mood = prediction
    mood_counts = Counter(same_day_moods)
    predicted_mood = mood_counts.most_common(1)[0][0].capitalize()

    # Session recommendation for the predicted mood
    session_map = {
        "Anxious": {
            "name": "Safe Harbor Session",
            "duration": 5,
            "technique": "Box Breathing",
            "goal": "reduce_stress"
        },
        "Sad": {
            "name": "Sunrise Within",
            "duration": 5,
            "technique": "Heart Opening Breath",
            "goal": "feel_happier"
        },
        "Angry": {
            "name": "Storm to Stillness",
            "duration": 5,
            "technique": "4-7-8 Breath Release",
            "goal": "reduce_stress"
        },
        "Happy": {
            "name": "Joyful Stillness",
            "duration": 5,
            "technique": "Gratitude Breathing",
            "goal": "feel_happier"
        },
        "Excited": {
            "name": "Grounded Energy",
            "duration": 5,
            "technique": "Rhythmic Breathing",
            "goal": "increase_calm"
        },
        "Neutral": {
            "name": "Zen Harmony",
            "duration": 5,
            "technique": "Mindful Breathing",
            "goal": "reduce_stress"
        },
    }

    session = session_map.get(predicted_mood, session_map["Neutral"])
    total = len(same_day_moods)
    confidence = round(mood_counts.most_common(1)[0][1] / total, 2)

    return {
        "status": "success",
        "predicted_mood": predicted_mood,
        "recommended_session": session,
        "confidence": confidence,
        "message": f"You might feel {predicted_mood} tomorrow"
    }


# ================= ADAPTIVE SESSION DURATION (NEW FEATURE 2) =================
@router.get("/adaptive-duration/{user_id}")
def get_adaptive_duration(user_id: int, db: Session = Depends(get_db)):
    """
    Calculates how long the user actually meditates on average
    by comparing started_at vs completed_at timestamps.
    Returns the nearest valid duration: 5, 8, 10, 12, or 15 min.
    Requires at least 3 completed sessions to activate.
    """
    completed = db.query(MeditationSession).filter(
        MeditationSession.user_id == user_id,
        MeditationSession.status == "completed",
        MeditationSession.started_at != None,
        MeditationSession.completed_at != None
    ).order_by(MeditationSession.completed_at.desc()).limit(10).all()

    if len(completed) < 3:
        return {
            "status": "insufficient_data",
            "adaptive_duration": None,
            "average_actual_minutes": None,
            "sessions_analysed": len(completed),
            "message": "Complete more sessions to unlock adaptive duration"
        }

    # Calculate real time spent in each session
    actual_durations = []
    for s in completed:
        if s.started_at and s.completed_at:
            diff_seconds = (s.completed_at - s.started_at).total_seconds()
            diff_minutes = diff_seconds / 60
            # Only count realistic durations (1 to 30 minutes)
            if 1 <= diff_minutes <= 30:
                actual_durations.append(diff_minutes)

    if len(actual_durations) < 2:
        return {
            "status": "insufficient_data",
            "adaptive_duration": None,
            "average_actual_minutes": None,
            "sessions_analysed": len(actual_durations),
            "message": "Not enough completed session data yet"
        }

    avg_minutes = sum(actual_durations) / len(actual_durations)

    # Round to nearest valid session duration
    valid_durations = [5, 8, 10, 12, 15]
    adaptive = min(valid_durations, key=lambda x: abs(x - avg_minutes))

    return {
        "status": "success",
        "adaptive_duration": adaptive,
        "average_actual_minutes": round(avg_minutes, 1),
        "sessions_analysed": len(actual_durations),
        "message": f"AI noticed you complete ~{round(avg_minutes)} min sessions"
    }

@router.get("/mood-prediction/{user_id}")
def predict_mood(user_id: int, db: Session = Depends(get_db)):
    from models import EmotionLog
    from collections import Counter
    from datetime import datetime, timedelta

    logs = db.query(EmotionLog).filter(
        EmotionLog.user_id == user_id
    ).order_by(EmotionLog.created_at.desc()).limit(30).all()

    if len(logs) < 3:
        return {
            "status": "insufficient_data",
            "predicted_mood": None,
            "recommended_session": None,
            "message": "Log mood for a few more days to unlock predictions"
        }

    tomorrow_dow = (datetime.utcnow().weekday() + 1) % 7
    same_day_moods = [
        log.mood.lower() for log in logs
        if log.created_at.weekday() == tomorrow_dow
    ]
    if len(same_day_moods) < 2:
        same_day_moods = [log.mood.lower() for log in logs[:7]]

    mood_counts = Counter(same_day_moods)
    predicted_mood = mood_counts.most_common(1)[0][0].capitalize()

    session_map = {
        "Anxious": {"name": "Safe Harbor Session",  "duration": 5,  "technique": "Box Breathing"},
        "Sad":     {"name": "Sunrise Within",        "duration": 5,  "technique": "Heart Opening Breath"},
        "Angry":   {"name": "Storm to Stillness",    "duration": 5,  "technique": "4-7-8 Breath Release"},
        "Happy":   {"name": "Joyful Stillness",      "duration": 5,  "technique": "Gratitude Breathing"},
        "Excited": {"name": "Grounded Energy",       "duration": 5,  "technique": "Rhythmic Breathing"},
        "Neutral": {"name": "Zen Harmony",           "duration": 5,  "technique": "Mindful Breathing"},
    }
    session = session_map.get(predicted_mood, session_map["Neutral"])

    return {
        "status": "success",
        "predicted_mood": predicted_mood,
        "recommended_session": session,
        "confidence": round(mood_counts.most_common(1)[0][1] / len(same_day_moods), 2),
        "message": f"You might feel {predicted_mood} tomorrow"
    }

@router.get("/adaptive-duration-v2/{user_id}")
def get_adaptive_duration_v2(user_id: int, db: Session = Depends(get_db)):
    from models import MeditationSession

    completed = db.query(MeditationSession).filter(
        MeditationSession.user_id == user_id,
        MeditationSession.status == "completed",
        MeditationSession.started_at != None,
        MeditationSession.completed_at != None
    ).order_by(MeditationSession.completed_at.desc()).limit(10).all()

    if len(completed) < 3:
        return {
            "status": "insufficient_data",
            "adaptive_duration": None,
            "message": "Complete more sessions to unlock adaptive duration"
        }

    actual_durations = []
    for s in completed:
        if s.started_at and s.completed_at:
            diff = (s.completed_at - s.started_at).total_seconds() / 60
            if 1 <= diff <= 30:
                actual_durations.append(diff)

    if len(actual_durations) < 2:
        return {
            "status": "insufficient_data",
            "adaptive_duration": None,
            "message": "Not enough completed session data yet"
        }

    avg = sum(actual_durations) / len(actual_durations)
    valid = [5, 8, 10, 12, 15]
    adaptive = min(valid, key=lambda x: abs(x - avg))

    return {
        "status": "success",
        "adaptive_duration": adaptive,
        "average_actual_minutes": round(avg, 1),
        "sessions_analysed": len(actual_durations),
        "message": f"AI noticed you complete ~{round(avg)} min sessions"
    }


# ADD THIS TO routers/analytics.py
# Paste at the very END of the file, after the last endpoint

@router.get("/mood-week/{user_id}")
def get_mood_week(user_id: int, db: Session = Depends(get_db)):
    from models import EmotionLog
    from sqlalchemy import func

    today = datetime.utcnow().date()
    monday = today - timedelta(days=today.weekday())
    day_names = ["Mon", "Tue", "Wed", "Thu", "Fri", "Sat", "Sun"]

    emoji_map = {
        "Happy":   {"emoji": "😊", "bg": "#FFF9E6", "border": "#F5C518"},
        "Sad":     {"emoji": "😢", "bg": "#EEF3FB", "border": "#85B7EB"},
        "Angry":   {"emoji": "😠", "bg": "#FAECE7", "border": "#D85A30"},
        "Anxious": {"emoji": "😰", "bg": "#F3F0FD", "border": "#AFA9EC"},
        "Neutral": {"emoji": "😐", "bg": "#F1EFE8", "border": "#B4B2A9"},
        "Excited": {"emoji": "🤩", "bg": "#FFF0F6", "border": "#ED93B1"},
        "Calm":    {"emoji": "😌", "bg": "#E1F5EE", "border": "#1D9E75"},
        "Relaxed": {"emoji": "😌", "bg": "#E1F5EE", "border": "#1D9E75"},
        "Focused": {"emoji": "🧘", "bg": "#E6F1FB", "border": "#185FA5"},
    }

    # Get ALL logs for this user from the past 30 days in one query
    thirty_days_ago = today - timedelta(days=30)
    all_logs = db.query(EmotionLog).filter(
        EmotionLog.user_id == user_id,
        func.date(EmotionLog.created_at) >= thirty_days_ago
    ).order_by(EmotionLog.created_at.desc()).all()

    # Group logs by date
    logs_by_date = {}
    for log in all_logs:
        log_date = log.created_at.date() if hasattr(log.created_at, 'date') else log.created_at
        if str(log_date) not in logs_by_date:
            logs_by_date[str(log_date)] = log

    week_data = []
    for i in range(7):
        day_date = monday + timedelta(days=i)
        is_future = day_date > today
        date_str = str(day_date)

        if is_future:
            week_data.append({
                "day": day_names[i], "date": date_str,
                "mood": None, "emoji": "?",
                "bg_color": "#F5F5F5", "border_color": "#CCCCCC",
                "label": "Not yet", "logged": False, "is_future": True
            })
            continue

        log = logs_by_date.get(date_str)
        if log:
            mood_name = log.mood.capitalize() if log.mood else "Neutral"
            info = emoji_map.get(mood_name, {
                "emoji": "😐", "bg": "#F1EFE8", "border": "#B4B2A9"
            })
            week_data.append({
                "day": day_names[i], "date": date_str,
                "mood": mood_name, "emoji": info["emoji"],
                "bg_color": info["bg"], "border_color": info["border"],
                "label": mood_name, "logged": True, "is_future": False
            })
        else:
            week_data.append({
                "day": day_names[i], "date": date_str,
                "mood": None, "emoji": "-",
                "bg_color": "#F5F5F5", "border_color": "#DDDDDD",
                "label": "No log", "logged": False, "is_future": False
            })

    last_logged = next(
        (d for d in reversed(week_data) if d["logged"]), None
    )

    return {
        "status": "success",
        "week": week_data,
        "last_logged": last_logged
    }