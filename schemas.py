from pydantic import BaseModel, EmailStr, field_validator, model_validator
from typing import Optional, List
import re


# ================= USER SIGNUP =================
class UserSignupRequest(BaseModel):
    name: str
    email: str
    phone_number: str
    password: str
    confirm_password: str
    enable_notifications: bool

    # -------- PHONE VALIDATION --------
    @field_validator("phone_number")
    @classmethod
    def validate_phone(cls, v: str):
        pattern = r"^\+\d{1,3}\d{7,12}$"
        if not re.match(pattern, v):
            raise ValueError(
                "Phone number must include country code and valid digits (e.g., +919876543210)"
            )
        return v

    # -------- NAME VALIDATION --------
    @field_validator("name")
    @classmethod
    def validate_name(cls, v: str):
        if not re.match(r'^[A-Za-z]+$', v):
            raise ValueError("Name is not valid. Only alphabets allowed.")
        return v

    # -------- EMAIL VALIDATION --------
    @field_validator("email")
    @classmethod
    def validate_email(cls, v: str):
        if not re.match(r'^[A-Za-z0-9]+@gmail\.com$', v):
            raise ValueError("Email is not valid. Use format like example@gmail.com")
        return v

    # -------- PASSWORD VALIDATION --------
    @field_validator("password")
    @classmethod
    def validate_password(cls, v: str):
        if len(v) < 8:
            raise ValueError("Password must be at least 8 characters long")

        if not re.search(r"[A-Z]", v):
            raise ValueError("Password must contain at least one uppercase letter")

        if not re.search(r"[a-z]", v):
            raise ValueError("Password must contain at least one lowercase letter")

        if not re.search(r"\d", v):
            raise ValueError("Password must contain at least one number")

        if not re.search(r"[!@#$%^&*(),.?\":{}|<>]", v):
            raise ValueError("Password must contain at least one special character")

        return v

    # -------- MATCH PASSWORDS SAFELY --------
    @model_validator(mode="after")
    def validate_passwords_match(self):
        if self.password != self.confirm_password:
            raise ValueError("Passwords do not match")
        return self


class UserSignupResponse(BaseModel):
    status: str
    message: str


# ================= LOGIN (EMAIL OR PHONE) =================
class UserLoginRequest(BaseModel):
    email: Optional[str] = None
    phone_number: Optional[str] = None
    password: str

    # -------- EMAIL VALIDATION --------
    @field_validator("email")
    @classmethod
    def validate_email_login(cls, v: Optional[str]):
        if v is None or v == "":
            return None

        if not re.match(r'^[A-Za-z0-9]+@gmail\.com$', v):
            raise ValueError("Email is not valid. Use format like example@gmail.com")

        return v

    # -------- PHONE VALIDATION --------
    @field_validator("phone_number")
    @classmethod
    def validate_phone_optional(cls, v: Optional[str]):
        if v is None or v == "":
            return None

        pattern = r"^\+\d{1,3}\d{7,12}$"
        if not re.match(pattern, v):
            raise ValueError("Invalid phone number format")

        return v

    # -------- ENSURE ONE IS PRESENT --------
    @model_validator(mode="after")
    def validate_login_identifier(self):
        if not self.email and not self.phone_number:
            raise ValueError("Provide email or phone_number")
        return self


class UserLoginResponse(BaseModel):
    status: str
    message: str
    user_id: int
    name: str


# ================= DASHBOARD =================
class DashboardResponse(BaseModel):
    total_sessions: int
    total_hours: float
    level: int
    graph_data: List[float]
    profile_completed: bool


# ================= CHECKIN =================
class CheckInRequest(BaseModel):
    user_id: int
    mood_score: float


class SimpleResponse(BaseModel):
    status: str
    message: str


# ================= GOAL =================
class GoalSelectionRequest(BaseModel):
    user_id: int
    goal_type: str


class GoalSelectionResponse(BaseModel):
    status: str
    message: str


# ================= EMOTION =================
class EmotionRequest(BaseModel):
    user_id: int
    mood: str
    thought: Optional[str] = None


class EmotionResponse(BaseModel):
    status: str = "success"
    message: str = "Emotion predicted"
    predicted_emotion: str
    confidence: float


# ================= RECOMMENDATION =================
class RecommendPlanRequest(BaseModel):
    user_id: int
    goal_type: str
    experience_level: str
    predicted_emotion: str


class RecommendPlanResponse(BaseModel):
    meditation_type: str
    session_name: str
    duration: int
    technique: str   # ✅ ADDED
    guidance_style: str
    message: str
    match_score: float


# ================= PROFILE =================
class ProfileResponse(BaseModel):
    id: int
    name: str
    email: str
    profile_image: Optional[str]
    enable_notifications: bool
    data_sharing_consent: bool

    class Config:
        from_attributes = True


class UpdatePreferences(BaseModel):
    enable_notifications: bool
    data_sharing_consent: bool


# ================= FORGOT PASSWORD =================
class ForgotPasswordRequest(BaseModel):
    email: EmailStr


class VerifyOTPRequest(BaseModel):
    email: EmailStr
    otp: str


class ResetPasswordRequest(BaseModel):
    email: EmailStr
    new_password: str