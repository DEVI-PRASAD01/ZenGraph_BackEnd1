from fastapi import APIRouter
from pydantic import BaseModel
from ai.emotion_model import predict_emotion
from ai.recommendation_engine import recommend_session
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

    if "sleep" in text or "can't sleep" in text:
        return "sleep"

    if "focus" in text or "concentrate" in text or "study" in text:
        return "focus"

    if "anxious" in text or "stress" in text or "panic" in text:
        return "anxiety"

    if "relax" in text or "calm" in text:
        return "relax"

    if "sad" in text or "down" in text:
        return "sadness"

    return "general"


# ==============================
# DYNAMIC AI RESPONSE
# ==============================
def generate_ai_reply(intent, session):

    responses = {

        "sleep": [
            "It sounds like you're having trouble sleeping.",
            "Your body might need some rest.",
            "Let's help your mind slow down for sleep."
        ],

        "focus": [
            "It seems you're trying to improve concentration.",
            "Let's help you clear distractions and focus.",
            "A focused mind can improve productivity."
        ],

        "anxiety": [
            "It seems you're feeling anxious.",
            "Let's take a moment to calm your thoughts.",
            "Slow breathing can help reduce anxiety."
        ],

        "relax": [
            "It sounds like you need some relaxation.",
            "Let's help your body release tension.",
            "Taking time to relax can restore balance."
        ],

        "sadness": [
            "It seems you're feeling a bit down.",
            "Taking a mindful moment may help improve your mood.",
            "A calming meditation may help uplift your thoughts."
        ],

        "general": [
            "I'm here to support your mindfulness journey.",
            "A short meditation may help reset your mind.",
            "Taking a moment to breathe can help center your thoughts."
        ]
    }

    base_message = random.choice(responses.get(intent, responses["general"]))

    return f"{base_message} A {session['duration']} minute {session['title']} meditation may help you right now."


# ==============================
# AI COACH CHAT ENDPOINT
# ==============================
@router.post("/coach-chat")
def coach_chat(data: CoachRequest):

    user_id = data.user_id
    message = data.message

    try:

        # Save conversation memory
        if user_id not in conversation_memory:
            conversation_memory[user_id] = []

        conversation_memory[user_id].append(message)

        # Keep last 5 messages only
        if len(conversation_memory[user_id]) > 5:
            conversation_memory[user_id].pop(0)

        # Emotion detection
        emotion, confidence = predict_emotion(message)

        # Intent detection
        intent = detect_intent(message)

        # Meditation recommendation
        recommendation = recommend_session(intent)

        # Dynamic AI response
        reply = generate_ai_reply(intent, recommendation)

        return {
            "emotion": emotion,
            "confidence": confidence,
            "intent": intent,
            "reply": reply,
            "recommended_session": recommendation,
            "conversation_memory": conversation_memory[user_id]
        }

    except Exception:

        # Safe fallback response
        return {
            "emotion": "unknown",
            "confidence": 0,
            "intent": "general",
            "reply": "I'm here to help. A short breathing meditation may help you relax.",
            "recommended_session": {
                "title": "Mindful Breathing",
                "duration": 5
            },
            "conversation_memory": []
        }