from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database import get_db
from models import EmotionLog, CheckIn
from schemas import EmotionRequest, EmotionResponse, CheckInRequest, SimpleResponse
from ai.emotion_model import predict_emotion

router = APIRouter(prefix="/ai", tags=["AI"])


# ================= EMOTION PREDICTION =================
@router.post("/predict-emotion", response_model=EmotionResponse)
def detect_emotion(data: EmotionRequest, db: Session = Depends(get_db)):

    predicted, confidence = predict_emotion(data.thought or "")

    log = EmotionLog(
        user_id=data.user_id,
        mood=data.mood,
        thought=data.thought,
        predicted_emotion=predicted,
        confidence=confidence
    )

    db.add(log)
    db.commit()

    return EmotionResponse(
        status="success",
        message="Emotion predicted successfully",
        predicted_emotion=predicted,
        confidence=confidence
    )


# ================= CHECK-IN API =================
@router.post("/checkin", response_model=SimpleResponse)
def checkin(data: CheckInRequest, db: Session = Depends(get_db)):

    print("CHECKIN HIT:", data.user_id, data.mood_score)

    new_checkin = CheckIn(
        user_id=data.user_id,
        mood_score=data.mood_score
    )

    db.add(new_checkin)
    db.commit()
    db.refresh(new_checkin)

    return SimpleResponse(
        status="success",
        message="Mood stored successfully"
    )