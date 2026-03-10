from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from datetime import datetime, timedelta
from pydantic import BaseModel

from database import get_db
from models import MeditationSession, AIPlan

router = APIRouter(prefix="/session", tags=["Session"])


# ================= EXPERIENCE SELECTION =================
class ExperienceRequest(BaseModel):
    user_id: int
    experience_level: str


@router.post("/experience/select")
def select_experience(data: ExperienceRequest, db: Session = Depends(get_db)):

    new_session = MeditationSession(
        user_id=data.user_id,
        goal="Setup",
        mood_before=None,
        stress_before=None,
        experience_level=data.experience_level,
        session_name="Initial Setup",
        duration=0,
        techniques="None",
        match_score=0,
        status="setup",
        start_time=None,
        end_time=None
    )

    db.add(new_session)
    db.commit()
    db.refresh(new_session)

    return {
        "status": "success",
        "message": "Experience level saved successfully",
        "experience_level": data.experience_level
    }


# ================= START SESSION =================
class StartSessionRequest(BaseModel):
    user_id: int
    plan_id: int


@router.post("/start")
def start_session(data: StartSessionRequest, db: Session = Depends(get_db)):

    # Check if user already has active session
    existing_active = db.query(MeditationSession).filter(
        MeditationSession.user_id == data.user_id,
        MeditationSession.status == "in_progress"
    ).first()

    # Auto complete old session
    if existing_active:
        existing_active.status = "completed"
        existing_active.end_time = datetime.utcnow()
        db.commit()

    # Get AI Plan
    plan = db.query(AIPlan).filter(AIPlan.id == data.plan_id).first()

    if not plan:
        return {"error": "Plan not found"}

    # Create new session
    new_session = MeditationSession(
        user_id=data.user_id,
        goal=plan.goal,
        mood_before=None,
        stress_before=None,
        experience_level=plan.level,
        session_name=plan.recommended_title,
        duration=plan.duration,
        techniques="AI Generated",
        match_score=plan.match_percent,
        status="in_progress",
        start_time=datetime.utcnow(),
        end_time=None
    )

    db.add(new_session)
    db.commit()
    db.refresh(new_session)

    return {
        "status": "success",
        "session_id": new_session.id,
        "session_name": new_session.session_name,
        "planned_duration": new_session.duration
    }


# ================= START LIBRARY SESSION =================
class StartLibrarySessionRequest(BaseModel):
    user_id: int
    title: str
    duration: int


@router.post("/start-library-session")
def start_library_session(data: StartLibrarySessionRequest, db: Session = Depends(get_db)):

    # Check active session
    existing_active = db.query(MeditationSession).filter(
        MeditationSession.user_id == data.user_id,
        MeditationSession.status == "in_progress"
    ).first()

    # Auto complete old session
    if existing_active:
        existing_active.status = "completed"
        existing_active.end_time = datetime.utcnow()
        db.commit()

    # Create library session
    new_session = MeditationSession(
        user_id=data.user_id,
        goal="Library Session",
        mood_before=None,
        stress_before=None,
        experience_level="General",
        session_name=data.title,
        duration=data.duration,
        techniques="Library",
        match_score=100,
        status="in_progress",
        start_time=datetime.utcnow(),
        end_time=None
    )

    db.add(new_session)
    db.commit()
    db.refresh(new_session)

    return {
        "status": "success",
        "session_id": new_session.id,
        "session_name": new_session.session_name,
        "planned_duration": new_session.duration
    }


# ================= COMPLETE SESSION =================
class CompleteSessionRequest(BaseModel):
    session_id: int


@router.post("/complete")
def complete_session(data: CompleteSessionRequest, db: Session = Depends(get_db)):

    session = db.query(MeditationSession).filter(
        MeditationSession.id == data.session_id
    ).first()

    if not session:
        return {"error": "Session not found"}

    if session.status == "completed":
        return {"error": "Session already completed"}

    session.end_time = datetime.utcnow()
    session.status = "completed"

    # Calculate real duration
    duration_seconds = (session.end_time - session.start_time).total_seconds()

    completed_minutes = int(duration_seconds // 60)

    if duration_seconds > 0 and completed_minutes == 0:
        completed_minutes = 1

    session.duration = completed_minutes

    db.commit()

    return {
        "status": "success",
        "duration_minutes": completed_minutes
    }


# ================= USER STATS =================
@router.get("/stats/{user_id}")
def get_user_stats(user_id: int, db: Session = Depends(get_db)):

    sessions = db.query(MeditationSession).filter(
        MeditationSession.user_id == user_id,
        MeditationSession.status == "completed"
    ).all()

    total_minutes = sum(s.duration or 0 for s in sessions)

    week_ago = datetime.utcnow() - timedelta(days=7)

    weekly_minutes = sum(
        s.duration or 0
        for s in sessions
        if s.end_time and s.end_time >= week_ago
    )

    level = (total_minutes // 60) + 1

    return {
        "daily_streak": 0,
        "level": level,
        "weekly_hours": round(weekly_minutes / 60, 2)
    }