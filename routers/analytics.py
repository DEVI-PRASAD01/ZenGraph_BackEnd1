from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from sqlalchemy import func
from datetime import datetime, timedelta

from database import get_db
from models import MeditationSession, CheckIn

router = APIRouter(prefix="/analytics", tags=["Analytics"])


# ================= PROGRESS ANALYTICS =================
@router.get("/progress/{user_id}")
def progress_analytics(user_id: int, period: str = "day", db: Session = Depends(get_db)):

    now = datetime.utcnow()

    # Determine date range
    if period == "day":
        start_date = now.replace(hour=0, minute=0, second=0, microsecond=0)

    elif period == "week":
        start_date = now - timedelta(days=7)

    elif period == "month":
        start_date = now - timedelta(days=30)

    else:
        start_date = now - timedelta(days=1)

    # Fetch sessions
    sessions = db.query(MeditationSession).filter(
        MeditationSession.user_id == user_id,
        MeditationSession.status == "completed",
        MeditationSession.end_time >= start_date
    ).all()

    mindful_minutes = sum(s.duration or 0 for s in sessions)

    # Mood checkins
    checkins = db.query(CheckIn).filter(
        CheckIn.user_id == user_id,
        CheckIn.created_at >= start_date
    ).all()

    # Calm score calculation
    if checkins:
        avg_mood = sum(c.mood_score for c in checkins) / len(checkins)
        calm_score = int(avg_mood * 10)
    else:
        calm_score = 0

    # Stress reduction estimation
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
        if s.end_time:
            diff = (s.end_time.date() - week_start).days
            if 0 <= diff < 7:
                completion[diff] += 1

    return completion