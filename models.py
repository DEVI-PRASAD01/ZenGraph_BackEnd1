from sqlalchemy import (
    Column,
    Integer,
    String,
    Boolean,
    Float,
    ForeignKey,
    TIMESTAMP,
    DateTime,
    Text
)
from sqlalchemy.sql import func
from database import Base


# =========================
# USERS TABLE
# =========================
class User(Base):
    __tablename__ = "users"

    id = Column(Integer, primary_key=True, index=True, autoincrement=True)

    name = Column(String(100), nullable=False)
    email = Column(String(150), unique=True, nullable=False, index=True)
    phone_number = Column(String(20), nullable=False)

    password = Column(String(255), nullable=False)

    enable_notifications = Column(Boolean, default=True)

    # 🔥 NEW PROFILE FIELDS
    profile_image = Column(String(255), nullable=True)
    data_sharing_consent = Column(Boolean, default=False)

    # 🔐 PASSWORD RESET FIELDS
    reset_otp = Column(String(6), nullable=True)
    otp_created_at = Column(DateTime, nullable=True)

    created_at = Column(TIMESTAMP, server_default=func.now())


# =========================
# CHECKIN TABLE
# =========================
class CheckIn(Base):
    __tablename__ = "checkins"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    mood_score = Column(Float)

    created_at = Column(TIMESTAMP, server_default=func.now())


# =========================
# USER GOALS TABLE
# =========================
class UserGoal(Base):
    __tablename__ = "user_goals"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer, ForeignKey("users.id"))
    goal_type = Column(String(100), nullable=False)

    created_at = Column(DateTime(timezone=True), server_default=func.now())


# =========================
# EMOTION LOG TABLE
# =========================
class EmotionLog(Base):
    __tablename__ = "emotion_logs"

    id = Column(Integer, primary_key=True, index=True)
    user_id = Column(Integer)
    mood = Column(String(50))
    thought = Column(Text)
    predicted_emotion = Column(String(50))
    confidence = Column(String(20))

    created_at = Column(DateTime(timezone=True), server_default=func.now())


# =========================
# MEDITATION SESSION TABLE
# =========================
class MeditationSession(Base):
    __tablename__ = "meditation_sessions"

    id = Column(Integer, primary_key=True, index=True)

    user_id = Column(Integer, nullable=False)

    goal = Column(String(100))
    mood_before = Column(Integer)
    stress_before = Column(Integer)
    experience_level = Column(String(50))
    session_name = Column(String(150))
    duration = Column(Integer)
    techniques = Column(String(255))
    match_score = Column(Integer)

    status = Column(String(50), default="generated")

    start_time = Column(TIMESTAMP, nullable=True)
    end_time = Column(TIMESTAMP, nullable=True)

    created_at = Column(TIMESTAMP, server_default=func.now())


# =========================
# AI PLAN TABLE
# =========================
class AIPlan(Base):
    __tablename__ = "ai_plans"

    id = Column(Integer, primary_key=True, index=True)

    user_id = Column(Integer, ForeignKey("users.id"))

    goal = Column(String(100))
    mood = Column(String(50))
    level = Column(String(50))
    recommended_title = Column(String(200))
    duration = Column(Integer)
    match_percent = Column(Integer)

    created_at = Column(TIMESTAMP, server_default=func.now())