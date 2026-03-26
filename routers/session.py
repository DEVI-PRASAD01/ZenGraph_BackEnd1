from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from pydantic import BaseModel
from typing import Optional
from database import get_db
from models import MeditationSession, AIPlan
from datetime import datetime, timedelta
import pytz
import json

IST = pytz.timezone("Asia/Kolkata")

router = APIRouter(prefix="/session", tags=["Session"])

EXPERIENCE_DURATION = {
    "beginner":     5,
    "intermediate": 10,
    "advanced":     15,
}

SESSION_LIBRARY = {
    ("reduce_stress", "happy"):   {"name": "Joyful Stillness",      "technique": "Gratitude Breathing",       "components": ["Gratitude Visualization", "Soft Body Scan", "Joyful Affirmations"],            "goal": "Sustain your positive energy with mindful awareness",          "color": "#A8D8A8"},
    ("reduce_stress", "sad"):     {"name": "Gentle Healing Flow",    "technique": "Compassion Breathing",      "components": ["Self-Compassion Meditation", "Gentle Body Release", "Healing Visualization"], "goal": "Soften emotional pain and find inner warmth",                  "color": "#C9B8E8"},
    ("reduce_stress", "angry"):   {"name": "Storm to Stillness",     "technique": "4-7-8 Breath Release",      "components": ["Anger Release Breathing", "Progressive Muscle Relaxation", "Peace Visualization"], "goal": "Dissolve tension and restore emotional balance",           "color": "#F4A460"},
    ("reduce_stress", "anxious"): {"name": "Safe Harbor Session",    "technique": "Box Breathing",             "components": ["5-4-3-2-1 Grounding", "Box Breathing", "Safety Visualization"],               "goal": "Anchor your mind and calm the nervous system",                 "color": "#87CEEB"},
    ("reduce_stress", "neutral"): {"name": "Zen Harmony",            "technique": "Mindful Breathing",         "components": ["Breath Awareness", "Body Scan", "Open Awareness"],                            "goal": "Maintain stability and clarity",                               "color": "#B0E0E6"},
    ("reduce_stress", "excited"): {"name": "Grounded Energy",        "technique": "Rhythmic Breathing",        "components": ["Energy Channeling", "Balanced Breath", "Grounding Visualization"],            "goal": "Balance high energy with peaceful awareness",                  "color": "#FFD700"},
    ("improve_focus", "happy"):   {"name": "Peak Performance Flow",  "technique": "Focus Anchoring",           "components": ["Intention Setting", "Single-Point Focus", "Clarity Visualization"],           "goal": "Sharpen cognitive clarity at your energetic peak",             "color": "#98FB98"},
    ("improve_focus", "sad"):     {"name": "Mental Uplift Session",  "technique": "Energizing Breath",         "components": ["Mood Lift Breathing", "Cognitive Reset", "Focus Rebuilding"],                 "goal": "Clear mental fog and rebuild concentration",                   "color": "#DDA0DD"},
    ("improve_focus", "angry"):   {"name": "Clarity Through Calm",   "technique": "Cooling Breath",            "components": ["Tension Release", "Mental Reframing", "Focus Lock"],                         "goal": "Channel strong emotions into productive clarity",              "color": "#FA8072"},
    ("improve_focus", "anxious"): {"name": "Steady Mind Bridge",     "technique": "4-4-4 Focus Breath",        "components": ["Anxiety Dissolve", "Present Moment Anchor", "Concentration Build"],           "goal": "Settle the mind and restore cognitive focus",                  "color": "#ADD8E6"},
    ("improve_focus", "neutral"): {"name": "Mind Balance Session",   "technique": "Breathwork",                "components": ["Breathwork", "Body Scan", "Relaxing Music"],                                  "goal": "Improve overall well-being and find inner tranquility",        "color": "#E6E6FA"},
    ("improve_focus", "excited"): {"name": "Focus Ignition",         "technique": "Power Breath",              "components": ["Energy to Focus", "Concentration Lock", "Achievement Visualization"],         "goal": "Convert excitement into productive mental focus",              "color": "#FFB347"},
    ("sleep_better", "happy"):    {"name": "Peaceful Sunset",        "technique": "Sleep Induction Breath",    "components": ["Gratitude Review", "Body Relaxation", "Dream Visualization"],                 "goal": "Transition from happiness into deep restorative sleep",        "color": "#FFB6C1"},
    ("sleep_better", "sad"):      {"name": "Nighttime Comfort",      "technique": "Soothing Breath",           "components": ["Emotional Release", "Self-Compassion", "Sleep Sanctuary Visualization"],      "goal": "Let go of the day and drift into healing sleep",               "color": "#B8A9C9"},
    ("sleep_better", "angry"):    {"name": "Release & Rest",         "technique": "Exhale Release Breath",     "components": ["Anger Discharge", "Physical Unwinding", "Peaceful Sleep Entry"],              "goal": "Release stored tension for deep night rest",                   "color": "#F08080"},
    ("sleep_better", "anxious"):  {"name": "Worry-Free Night",       "technique": "4-7-8 Sleep Breath",        "components": ["Worry Release", "Progressive Relaxation", "Safe Sleep Visualization"],        "goal": "Calm the nervous system for uninterrupted sleep",              "color": "#B0C4DE"},
    ("sleep_better", "neutral"):  {"name": "Cosmic Calm Journey",    "technique": "Deep Sleep Breath",         "components": ["Body Scan", "Relaxing Music", "Sleep Visualization"],                         "goal": "Guide your mind gently into restful sleep",                    "color": "#9B8EC4"},
    ("sleep_better", "excited"):  {"name": "Soft Landing",           "technique": "Slowing Breath",            "components": ["Energy Wind-Down", "Muscle Relaxation", "Night Sky Visualization"],           "goal": "Gradually lower energy for restorative sleep",                 "color": "#FFDAB9"},
    ("feel_happier", "happy"):    {"name": "Joy Amplifier",          "technique": "Loving Kindness",           "components": ["Gratitude Amplification", "Joy Breathing", "Happiness Anchoring"],            "goal": "Sustain and expand your natural sense of joy",                 "color": "#FFD700"},
    ("feel_happier", "sad"):      {"name": "Sunrise Within",         "technique": "Heart Opening Breath",      "components": ["Compassion Meditation", "Positive Memory Recall", "Hope Visualization"],      "goal": "Nurture seeds of happiness through gentle practice",           "color": "#FFA07A"},
    ("feel_happier", "angry"):    {"name": "Peace & Positivity",     "technique": "Release Breath",            "components": ["Anger Alchemy", "Forgiveness Meditation", "Joy Visualization"],               "goal": "Transform negative energy into positive wellbeing",            "color": "#FF8C69"},
    ("feel_happier", "anxious"):  {"name": "Calm & Cheerful",        "technique": "Calming Breath",            "components": ["Anxiety Release", "Positive Reframing", "Happiness Cultivation"],             "goal": "Find joy beyond the noise of anxious thoughts",                "color": "#87CEFA"},
    ("feel_happier", "neutral"):  {"name": "Inner Sunshine",         "technique": "Uplifting Breath",          "components": ["Mood Elevation", "Positive Intentions", "Gratitude Practice"],                "goal": "Cultivate warmth and positive emotional tone",                 "color": "#FFFACD"},
    ("feel_happier", "excited"):  {"name": "Radiant Joy Flow",       "technique": "Expansive Breath",          "components": ["Joy Expansion", "Celebration Meditation", "Future Happiness Vision"],         "goal": "Transform excitement into deep lasting happiness",             "color": "#FF69B4"},
    ("increase_calm", "happy"):   {"name": "Serene Glow",            "technique": "Peaceful Breath",           "components": ["Gentle Settling", "Calm Amplification", "Serenity Visualization"],           "goal": "Deepen calm while preserving your positive mood",              "color": "#90EE90"},
    ("increase_calm", "sad"):     {"name": "Still Waters",           "technique": "Ocean Breath",              "components": ["Sadness Acknowledgment", "Still Point Meditation", "Peace Visualization"],    "goal": "Access inner calm regardless of surface emotions",             "color": "#6495ED"},
    ("increase_calm", "angry"):   {"name": "Fire to Earth",          "technique": "Cooling Earth Breath",      "components": ["Fire Cooling", "Earth Grounding", "Stillness Meditation"],                   "goal": "Transform reactive energy into deep equanimity",               "color": "#CD853F"},
    ("increase_calm", "anxious"): {"name": "Anchor in the Storm",    "technique": "Grounding Breath",          "components": ["Grounding Practice", "Calm Center Finding", "Peace Anchoring"],              "goal": "Establish unshakeable inner calm",                             "color": "#4682B4"},
    ("increase_calm", "neutral"): {"name": "Deep Stillness",         "technique": "Stillness Breath",          "components": ["Silence Cultivation", "Deep Rest", "Inner Peace"],                           "goal": "Experience the deepest layers of inner calm",                  "color": "#778899"},
    ("increase_calm", "excited"): {"name": "Gentle Descent",         "technique": "Descending Breath",         "components": ["Energy Softening", "Calm Invitation", "Stillness Entry"],                    "goal": "Find the calm that underlies all states",                      "color": "#DEB887"},
    ("build_mindfulness", "happy"):   {"name": "Mindful Joy",           "technique": "Savoring Practice",         "components": ["Sensory Awareness", "Joy Savoring", "Present Moment Immersion"],             "goal": "Deepen presence and fully experience positive states",          "color": "#7FFF00"},
    ("build_mindfulness", "sad"):     {"name": "Compassionate Witness", "technique": "RAIN Meditation",           "components": ["Recognize", "Allow", "Investigate", "Nurture"],                              "goal": "Build mindful awareness of difficult emotions",                "color": "#9370DB"},
    ("build_mindfulness", "angry"):   {"name": "Mindful Pause",         "technique": "STOP Technique",            "components": ["Stop & Observe", "Breath Awareness", "Thoughtful Response"],                 "goal": "Cultivate the mindful space that enables wise action",         "color": "#DC143C"},
    ("build_mindfulness", "anxious"): {"name": "Present Safety",        "technique": "Present Moment Anchoring", "components": ["Sensory Grounding", "Thought Labeling", "Present Refuge"],                   "goal": "Build the skill of resting in present-moment awareness",       "color": "#00CED1"},
    ("build_mindfulness", "neutral"): {"name": "Pure Awareness",        "technique": "Open Monitoring",           "components": ["Bare Attention", "Non-judgment Practice", "Awareness Expansion"],            "goal": "Develop pure mindful awareness as a natural state",            "color": "#F5F5DC"},
    ("build_mindfulness", "excited"): {"name": "Mindful Energy",        "technique": "Energized Awareness",       "components": ["Energy Witnessing", "Mindful Movement Breath", "Presence Amplification"],   "goal": "Experience mindfulness as alive, vibrant presence",            "color": "#FF6347"},
}


def get_session_for_user(goal: str, mood: str, experience: str) -> dict:
    goal_key       = goal.lower().replace(" ", "_")
    mood_key       = mood.lower()
    experience_key = experience.lower().strip()
    session_data   = SESSION_LIBRARY.get(
        (goal_key, mood_key),
        SESSION_LIBRARY.get((goal_key, "neutral"), {
            "name": "Mindful Moment", "technique": "Mindful Breathing",
            "components": ["Breath Awareness", "Body Scan", "Open Awareness"],
            "goal": "Cultivate present-moment awareness", "color": "#B0E0E6"
        })
    )
    duration = EXPERIENCE_DURATION.get(experience_key, 5)
    return {**session_data, "duration_minutes": duration}


# ─────────────────────────────────────────────────────────────
#  SCHEMAS
# ─────────────────────────────────────────────────────────────

class StartSessionRequest(BaseModel):
    user_id:          int
    goal:             str
    mood_before:      str
    experience_level: str
    session_name:     str
    duration:         int
    techniques:       str
    match_score:      int


class CompleteSessionRequest(BaseModel):
    mood_after:      str
    actual_duration: Optional[int] = None  # real minutes spent (from Android timer)
    notes:           Optional[str] = None


class PauseResumeRequest(BaseModel):
    action: str


# ─────────────────────────────────────────────────────────────
#  ROUTES
# ─────────────────────────────────────────────────────────────

@router.get("/recommendation")
def get_session_recommendation(
    user_id: int, mood: str, goal: str,
    experience: str = "beginner",
    db: Session = Depends(get_db)
):
    session = get_session_for_user(goal, mood, experience)
    plan = AIPlan(
        user_id=user_id, goal=goal, mood=mood,
        level=experience.capitalize(),
        recommended_title=session["name"],
        duration=session["duration_minutes"],
        match_percent=85
    )
    db.add(plan)
    db.commit()
    return {"status": "success", "session": session}


@router.post("/start")
def start_session(data: StartSessionRequest, db: Session = Depends(get_db)):
    correct_duration = EXPERIENCE_DURATION.get(data.experience_level.lower(), 5)
    new_session = MeditationSession(
        user_id=data.user_id,
        session_name=data.session_name,
        goal=data.goal,
        mood_before=data.mood_before,
        experience_level=data.experience_level,
        duration=correct_duration,
        techniques=data.techniques,
        match_score=data.match_score,
        status="started",
        started_at=datetime.now(IST)
    )
    db.add(new_session)
    db.commit()
    db.refresh(new_session)
    return {
        "status":     "success",
        "session_id": new_session.id,
        "session": {
            "id":               new_session.id,
            "session_name":     new_session.session_name,
            "duration_minutes": correct_duration,
            "mood_before":      new_session.mood_before,
            "experience_level": new_session.experience_level,
        }
    }


@router.post("/complete/{session_id}")
def complete_session(
    session_id: int,
    data: CompleteSessionRequest,
    db: Session = Depends(get_db)
):
    """
    POST /session/complete/{session_id}
    Body JSON:
    {
        "mood_after":      "Relaxed",
        "actual_duration": 3,
        "notes":           ""
    }
    actual_duration = real minutes the user meditated (from Android countdown timer).
    If omitted or 0, falls back to the session's planned duration.
    """
    session = db.query(MeditationSession).filter(
        MeditationSession.id == session_id
    ).first()
    if not session:
        raise HTTPException(status_code=404, detail="Session not found")

    planned_duration = session.duration or 5
    actual_minutes   = (
        data.actual_duration
        if (data.actual_duration and data.actual_duration > 0)
        else planned_duration
    )

    session.mood_after   = data.mood_after
    session.notes        = data.notes
    session.status       = "completed"
    session.completed_at = datetime.now(IST)
    session.duration     = actual_minutes   # update DB with real time spent
    db.commit()
    db.refresh(session)

    mood_scores = {
        "calm": 90, "relaxed": 85, "focused": 80,
        "happy": 75, "neutral": 60,
        "anxious": 30, "sad": 25, "angry": 20
    }
    before_score = mood_scores.get((session.mood_before or "neutral").lower(), 50)
    after_score  = mood_scores.get(data.mood_after.lower(), 60)
    improvement  = after_score - before_score

    if improvement >= 30:
        stress_label = "Significantly Reduced"
        focus_label  = "High"
    elif improvement >= 10:
        stress_label = "Moderate"
        focus_label  = "Moderate"
    else:
        stress_label = "Slight"
        focus_label  = "Slight"

    next_session = get_session_for_user(
        session.goal or "reduce_stress",
        data.mood_after,
        session.experience_level or "beginner"
    )

    return {
        "status": "success",
        "analysis": {
            "stress_reduced":    stress_label,
            "calm_level":        after_score,
            "focus_improvement": focus_label,
            "mood_before":       session.mood_before,
            "mood_after":        data.mood_after,
            "minutes_completed": actual_minutes,   # real time
            "duration_minutes":  actual_minutes,   # real time
            "planned_minutes":   planned_duration
        },
        "ai_recommendation": {
            "next_session":     next_session["name"],
            "duration_minutes": next_session["duration_minutes"],
            "technique":        next_session["technique"],
            "reason": f"Based on your {data.mood_after} mood, this will continue your progress."
        }
    }


@router.post("/pause/{session_id}")
def pause_session(session_id: int, db: Session = Depends(get_db)):
    session = db.query(MeditationSession).filter(
        MeditationSession.id == session_id).first()
    if not session:
        raise HTTPException(status_code=404, detail="Session not found")
    session.status = "paused"
    db.commit()
    return {"status": "paused", "session_id": session_id}


@router.post("/resume/{session_id}")
def resume_session(session_id: int, db: Session = Depends(get_db)):
    session = db.query(MeditationSession).filter(
        MeditationSession.id == session_id).first()
    if not session:
        raise HTTPException(status_code=404, detail="Session not found")
    session.status = "started"
    db.commit()
    return {"status": "resumed", "session_id": session_id}


@router.get("/history/{user_id}")
def get_session_history(user_id: int, db: Session = Depends(get_db)):
    sessions = db.query(MeditationSession).filter(
        MeditationSession.user_id == user_id
    ).order_by(MeditationSession.started_at.desc()).all()

    return {
        "status": "success",
        "sessions": [
            {
                "id":               s.id,
                "session_name":     s.session_name,
                "goal":             s.goal,
                "mood_before":      s.mood_before,
                "mood_after":       s.mood_after,
                "duration_minutes": s.duration,
                "experience_level": s.experience_level,
                "status":           s.status,
                "started_at":       str(s.started_at),
                "completed_at":     str(s.completed_at) if s.completed_at else None
            }
            for s in sessions
        ]
    }


@router.get("/stats/{user_id}")
def session_stats(user_id: int, db: Session = Depends(get_db)):
    all_sessions = db.query(MeditationSession).filter(
        MeditationSession.user_id == user_id
    ).all()
    completed  = [s for s in all_sessions if s.status == "completed"]
    total_mins = sum(s.duration or 0 for s in completed)

    streak = 0
    today  = datetime.utcnow().date()
    for i in range(30):
        check_date   = today - timedelta(days=i)
        day_sessions = [
            s for s in completed
            if s.completed_at and s.completed_at.date() == check_date
        ]
        if day_sessions:
            streak += 1
        else:
            break

    return {
        "status":             "success",
        "total_sessions":     len(all_sessions),
        "completed_sessions": len(completed),
        "total_minutes":      total_mins,
        "current_streak":     streak,
        "level":              (len(completed) // 5) + 1
    }