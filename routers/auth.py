import random
from datetime import datetime, timedelta

from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from fastapi_mail import FastMail, MessageSchema
from pydantic import BaseModel

from database import get_db
from models import User, MeditationSession, CheckIn, UserGoal
from email_config import conf
from schemas import (
    UserSignupRequest,
    UserSignupResponse,
    UserLoginRequest,
    UserLoginResponse,
    DashboardResponse,
    CheckInRequest,
    SimpleResponse,
    GoalSelectionRequest,
    GoalSelectionResponse,
    ForgotPasswordRequest,
    VerifyOTPRequest,
    ResetPasswordRequest
)

router = APIRouter(prefix="/auth", tags=["Authentication"])

# ================= SIGNUP =================
@router.post("/signup", response_model=UserSignupResponse)
def signup(user: UserSignupRequest, db: Session = Depends(get_db)):

    if user.password != user.confirm_password:
        raise HTTPException(status_code=400, detail="Passwords do not match")

    existing_user = db.query(User).filter(User.email == user.email).first()
    if existing_user:
        raise HTTPException(status_code=400, detail="Email already registered")

    new_user = User(
        name=user.name,
        email=user.email,
        phone_number=user.phone_number,
        password=user.password,
        enable_notifications=user.enable_notifications
    )

    db.add(new_user)
    db.commit()
    db.refresh(new_user)

    return UserSignupResponse(
        status="success",
        message="User registered successfully"
    )

# ================= LOGIN =================
@router.post("/login", response_model=UserLoginResponse)
def login(user: UserLoginRequest, db: Session = Depends(get_db)):
    db_user = None

    if user.email:
        db_user = db.query(User).filter(User.email == user.email).first()
    elif user.phone_number:
        db_user = db.query(User).filter(User.phone_number == user.phone_number).first()
    else:
        raise HTTPException(status_code=400, detail="Provide email or phone")

    if not db_user or user.password != db_user.password:
        raise HTTPException(
            status_code=401,
            detail="Invalid email or password"
        )

    return UserLoginResponse(
        status="success",
        message="Login successful",
        user_id=db_user.id,
        name=db_user.name
    )

# ================= DASHBOARD =================
@router.get("/dashboard/{user_id}", response_model=DashboardResponse)
def get_dashboard(user_id: int, db: Session = Depends(get_db)):

    sessions = db.query(MeditationSession).filter(
        MeditationSession.user_id == user_id,
        MeditationSession.status == "completed"
    ).all()

    total_sessions = len(sessions)
    total_minutes = sum([s.duration or 0 for s in sessions])
    total_hours = round(total_minutes / 60, 2)
    level = (total_sessions // 5) + 1

    checkins = (
        db.query(CheckIn)
        .filter(CheckIn.user_id == user_id)
        .order_by(CheckIn.created_at.desc())
        .limit(7)
        .all()
    )
    graph_data = [c.mood_score for c in checkins]

    goal_record = db.query(UserGoal).filter(
        UserGoal.user_id == user_id
    ).first()

    profile_completed = True if goal_record else False

    return DashboardResponse(
        total_sessions=total_sessions,
        total_hours=total_hours,
        level=level,
        graph_data=graph_data,
        profile_completed=profile_completed
    )

# ================= SELECT GOAL (original endpoint kept) =================
@router.post("/select-goal", response_model=GoalSelectionResponse)
def select_goal(data: GoalSelectionRequest, db: Session = Depends(get_db)):
    existing_goal = db.query(UserGoal).filter(UserGoal.user_id == data.user_id).first()

    if existing_goal:
        existing_goal.goal_type = data.goal_type
        db.commit()
    else:
        new_goal = UserGoal(
            user_id=data.user_id,
            goal_type=data.goal_type
        )
        db.add(new_goal)
        db.commit()

    return GoalSelectionResponse(
        status="success",
        message="Goal selection updated successfully"
    )


# ================= SAVE GOAL + EXPERIENCE (NEW) =================
class SaveGoalRequest(BaseModel):
    user_id: int
    goal_type: str    # e.g. "Reduce Stress"
    experience: str   # e.g. "beginner"

@router.post("/save-goal")
def save_goal(data: SaveGoalRequest, db: Session = Depends(get_db)):
    """
    POST /auth/save-goal
    Saves goal AND experience together. Called after user picks both.
    Replaces old goal if exists.
    """
    # Delete old and save fresh
    db.query(UserGoal).filter(UserGoal.user_id == data.user_id).delete()

    new_goal = UserGoal(
        user_id=data.user_id,
        goal_type=data.goal_type,
        experience=data.experience
    )
    db.add(new_goal)
    db.commit()

    return {
        "status": "success",
        "message": f"Goal '{data.goal_type}' with experience '{data.experience}' saved"
    }


# ================= GET GOAL =================
@router.get("/get-goal/{user_id}")
def get_goal(user_id: int, db: Session = Depends(get_db)):
    """
    GET /auth/get-goal/{user_id}
    Returns goal and experience for a user.
    """
    goal = db.query(UserGoal).filter(
        UserGoal.user_id == user_id
    ).order_by(UserGoal.created_at.desc()).first()

    if not goal:
        return {"status": "not_found", "goal_type": None, "experience": None}

    return {
        "status": "success",
        "goal_type": goal.goal_type,
        "experience": goal.experience
    }


# ================= CHECKIN =================
@router.post("/checkin", response_model=SimpleResponse)
def checkin(data: CheckInRequest, db: Session = Depends(get_db)):
    new_checkin = CheckIn(
        user_id=data.user_id,
        mood_score=data.mood_score
    )
    db.add(new_checkin)
    db.commit()
    return SimpleResponse(status="success", message="Check-in successful")

# ================= FORGOT PASSWORD =================
@router.post("/forgot-password")
async def forgot_password(data: ForgotPasswordRequest, db: Session = Depends(get_db)):

    user = db.query(User).filter(User.email == data.email).first()
    if not user:
        raise HTTPException(status_code=404, detail="Email not registered")

    otp = str(random.randint(1000, 9999))

    user.reset_otp = otp
    user.otp_created_at = datetime.utcnow()
    db.commit()

    message = MessageSchema(
        subject="ZenGraph Password Reset OTP",
        recipients=[data.email],
        body=f"""
        <h3>Password Reset OTP</h3>
        <p>Your OTP is: <b>{otp}</b></p>
        <p>This OTP is valid for 5 minutes.</p>
        """,
        subtype="html"
    )

    fm = FastMail(conf)
    await fm.send_message(message)

    return {"message": "OTP sent successfully"}

# ================= VERIFY OTP =================
@router.post("/verify-otp")
def verify_otp(data: VerifyOTPRequest, db: Session = Depends(get_db)):

    user = db.query(User).filter(User.email == data.email).first()

    if not user or not user.reset_otp:
        raise HTTPException(status_code=400, detail="Invalid request")

    if user.reset_otp != data.otp:
        raise HTTPException(status_code=400, detail="Incorrect OTP")

    if datetime.utcnow() > user.otp_created_at + timedelta(minutes=5):
        raise HTTPException(status_code=400, detail="OTP expired")

    return {"message": "OTP verified"}

# ================= RESET PASSWORD =================
@router.post("/reset-password")
def reset_password(data: ResetPasswordRequest, db: Session = Depends(get_db)):

    user = db.query(User).filter(User.email == data.email).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    user.password = data.new_password
    user.reset_otp = None
    user.otp_created_at = None
    db.commit()

    return {"message": "Password updated successfully"}