def generate_recommendation(goal: str, emotion: str, experience: str):

    meditation_type = "Mindfulness Meditation"
    guidance_style = "Calm and steady"
    message = "Stay aware of your breath and remain present."

    # Emotion-based logic
    if emotion == "Stressed":
        meditation_type = "Breathing Meditation"
        guidance_style = "Gentle and slow"
        message = "Take slow deep breaths to release stress."

    elif emotion == "Sad":
        meditation_type = "Gratitude Meditation"
        guidance_style = "Warm and comforting"
        message = "Focus on things you are grateful for."

    elif emotion == "Tense":
        meditation_type = "Body Scan Meditation"
        guidance_style = "Relaxing and grounding"
        message = "Relax each part of your body step by step."

    elif emotion == "Happy":
        meditation_type = "Loving-kindness Meditation"
        guidance_style = "Positive and uplifting"
        message = "Spread positive thoughts to yourself and others."

    elif emotion == "Calm":
        meditation_type = "Mindfulness Meditation"
        guidance_style = "Balanced and steady"
        message = "Maintain your calm awareness."

    # Experience-based duration (INTEGER)
    if experience == "Beginner":
        duration = 5
    elif experience == "Intermediate":
        duration = 10
    else:
        duration = 15

    return meditation_type, guidance_style, duration, message

def recommend_session(intent):

    sessions = {

        "sleep": {
            "title": "Deep Sleep Meditation",
            "duration": 15
        },

        "focus": {
            "title": "Mindful Focus",
            "duration": 10
        },

        "anxiety": {
            "title": "Quick Calm",
            "duration": 5
        },

        "relax": {
            "title": "Deep Relaxation",
            "duration": 10
        },

        "general": {
            "title": "Mindful Breathing",
            "duration": 5
        }
    }

    return sessions.get(intent, sessions["general"])