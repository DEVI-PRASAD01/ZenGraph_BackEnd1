from sqlalchemy.orm import Session
from models import MeditationLibrary
import joblib

# ================= LOAD AI MODEL =================

model = joblib.load("ml_models/recommendation_model.pkl")
goal_encoder = joblib.load("ml_models/goal_encoder.pkl")
emotion_encoder = joblib.load("ml_models/emotion_encoder.pkl")
experience_encoder = joblib.load("ml_models/experience_encoder.pkl")
session_encoder = joblib.load("ml_models/session_encoder.pkl")

print("✅ AI Recommendation Model Loaded")


# ================= GOAL MAPPING =================

GOAL_MAP = {
    "reduce_stress": "Stress Relief",
    "improve_focus": "Focus",
    "sleep_better": "Sleep",
    "build_mindfulness": "Relaxation",
    "increase_calm": "Relaxation",
    "feel_happier": "Relaxation"
}


# ================= GET SESSION FROM DATABASE =================

def get_session_from_db(db: Session, category: str):
    return db.query(MeditationLibrary)\
        .filter(MeditationLibrary.category == category)\
        .first()


# ================= AI RECOMMENDATION ENGINE =================

def generate_recommendation(db: Session, goal: str, emotion: str, experience: str):

    try:
        # Map frontend → model labels
        mapped_goal = GOAL_MAP.get(goal, "Relaxation")

        # Encode inputs
        g = goal_encoder.transform([mapped_goal])[0]
        e = emotion_encoder.transform([emotion])[0]
        x = experience_encoder.transform([experience])[0]

        # Predict
        prediction = model.predict([[g, e, x]])
        meditation_type = session_encoder.inverse_transform(prediction)[0]

        print("🧠 AI Prediction:", meditation_type)

        # Fetch from DB
        session = get_session_from_db(db, meditation_type)

        if session:
            return {
                "meditation_type": meditation_type,
                "session_name": session.title,
                "duration": session.duration,
                "technique": session.technique,
                "guidance_style": "Calm and supportive",
                "message": f"This {session.duration}-minute {meditation_type.lower()} session is recommended for you.",
                "match_score": 0.95
            }

        # fallback (if DB empty)
        return {
            "meditation_type": meditation_type,
            "session_name": "Mind Balance Session",
            "duration": 10,
            "technique": "Mindful Breathing",
            "guidance_style": "Calm and supportive",
            "message": "Fallback session",
            "match_score": 0.85
        }

    except Exception as e:
        print("❌ AI ERROR:", e)

        return {
            "meditation_type": "Mindfulness Meditation",
            "session_name": "Recovery Session",
            "duration": 10,
            "technique": "Mindful Breathing",
            "guidance_style": "Calm and supportive",
            "message": "System recovery recommendation",
            "match_score": 0.80
        }