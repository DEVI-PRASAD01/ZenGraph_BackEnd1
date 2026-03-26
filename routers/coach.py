from fastapi import APIRouter
from pydantic import BaseModel
from ai.emotion_model import predict_emotion

import random

router = APIRouter(prefix="/ai", tags=["AI Coach"])


# ==============================
# REQUEST MODEL
# ==============================
class CoachRequest(BaseModel):
    user_id: int
    message: str


# ==============================
# SIMPLE MEMORY STORE
# ==============================
conversation_memory = {}


# ==============================
# INTENT DETECTION
# ==============================
def detect_intent(text: str):

    text = text.lower()

    if "sleep" in text:
        return "Sleep Better"

    if "focus" in text or "study" in text:
        return "Improve Focus"

    if "stress" in text or "anxious" in text or "panic" in text:
        return "Reduce Stress"

    if "relax" in text or "calm" in text:
        return "Increase Calm"

    if "sad" in text or "down" in text:
        return "Feel Happier"

    return "Build Mindfulness"


# ==============================
# EXPERIENCE DETECTION
# ==============================
def detect_experience(text: str):

    text = text.lower()

    if "beginner" in text or "new" in text:
        return "Beginner"

    if "advanced" in text or "experienced" in text:
        return "Advanced"

    return "Intermediate"


# ==============================
# AI RESPONSE GENERATION
# ==============================
def generate_ai_reply(goal, recommendation):

    responses = [
        "I understand how you're feeling.",
        "Let's take a mindful moment together.",
        "A short meditation may help reset your mind.",
        "This session may help restore your balance.",
        "Let's guide your mind back to calm."
    ]

    base = random.choice(responses)

    return (
        f"{base} I recommend the session '{recommendation['session_name']}'. "
        f"It is a {recommendation['duration']} minute {recommendation['meditation_type']}."
    )


# ==============================
# AI COACH CHAT ENDPOINT
# ==============================
@router.post("/coach-chat")
def coach_chat(data: CoachRequest):

    user_id = data.user_id
    message = data.message

    try:

        # ================= MEMORY =================
        if user_id not in conversation_memory:
            conversation_memory[user_id] = []

        conversation_memory[user_id].append(message)

        if len(conversation_memory[user_id]) > 5:
            conversation_memory[user_id].pop(0)

        # ================= EMOTION AI =================
        emotion, confidence = predict_emotion(message)

        # ================= GOAL DETECTION =================
        goal = detect_intent(message)

        # ================= EXPERIENCE DETECTION =================
        experience = detect_experience(message)

        # ================= RECOMMENDATION ENGINE =================
        recommendation = generate_recommendation(goal, emotion, experience)

        # ================= AI REPLY =================
        reply = generate_ai_reply(goal, recommendation)

        return {
            "emotion": emotion,
            "confidence": confidence,
            "goal": goal,
            "experience": experience,
            "reply": reply,
            "recommended_session": recommendation,
            "conversation_memory": conversation_memory[user_id]
        }

    except Exception:

        return {
            "emotion": "Neutral",
            "confidence": 0,
            "goal": "Build Mindfulness",
            "experience": "Beginner",
            "reply": "Let's begin with a short breathing meditation.",
            "recommended_session": {
                "session_name": "Mindful Breathing",
                "duration": 5,
                "meditation_type": "Breathing Meditation"
            },
            "conversation_memory": []
        }