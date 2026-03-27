# ================= GOAL MAPPING =================

GOAL_MAP = {
    "stress":            "Stress Relief",
    "focus":             "Focus",
    "sleep":             "Sleep",
    "happy":             "Relaxation",
    "calm":              "Relaxation",
    "mindful":           "Relaxation",
    "reduce_stress":     "Stress Relief",
    "improve_focus":     "Focus",
    "sleep_better":      "Sleep",
    "feel_happier":      "Relaxation",
    "increase_calm":     "Relaxation",
    "build_mindfulness": "Relaxation",
    "reduce stress":     "Stress Relief",
    "improve focus":     "Focus",
    "sleep better":      "Sleep",
    "feel happier":      "Relaxation",
    "increase calm":     "Relaxation",
    "build mindfulness": "Relaxation",
    "relaxation":        "Relaxation",
}

# ================= SMART SESSION MAP =================
# Keyed by (goal, emotion) → session details
# Falls back to emotion-only if goal+emotion not found

SMART_SESSION_MAP = {
    # STRESS + emotion
    ("stress", "happy"):   {"session_name": "Joyful Calm",       "technique": "Gratitude Breathing",    "duration": 10, "message": "Maintain your happiness while releasing any lingering stress."},
    ("stress", "sad"):     {"session_name": "Gentle Release",    "technique": "Compassion Breathing",   "duration": 15, "message": "Gently dissolve stress and lift your spirit with each breath."},
    ("stress", "angry"):   {"session_name": "Cool Down",         "technique": "Anger Release Breathing","duration": 10, "message": "Transform frustration into calm with this stress-relief session."},
    ("stress", "anxious"): {"session_name": "Safe Ground",       "technique": "Box Breathing",          "duration": 8,  "message": "Anchor yourself and calm the nervous system from stress."},
    ("stress", "neutral"): {"session_name": "Stress Reset",      "technique": "Deep Belly Breathing",   "duration": 10, "message": "A simple reset to release the tension of the day."},
    ("stress", "excited"): {"session_name": "Calm the Rush",     "technique": "Rhythmic Breathing",     "duration": 8,  "message": "Channel your energy into calm, focused awareness."},

    # FOCUS + emotion
    ("focus", "happy"):    {"session_name": "Flow State",        "technique": "Focused Attention",      "duration": 12, "message": "Ride your positive energy into deep, productive focus."},
    ("focus", "sad"):      {"session_name": "Clarity Path",      "technique": "Mindful Observation",    "duration": 12, "message": "Gently clear the mind and find your focus through stillness."},
    ("focus", "angry"):    {"session_name": "Sharp Mind",        "technique": "Breath Counting",        "duration": 10, "message": "Release frustration and channel energy into laser focus."},
    ("focus", "anxious"):  {"session_name": "Steady Focus",      "technique": "Box Breathing",          "duration": 10, "message": "Calm anxiety and build the mental clarity you need."},
    ("focus", "neutral"):  {"session_name": "Deep Focus",        "technique": "Focused Attention",      "duration": 12, "message": "A clean slate session to prepare your mind for deep work."},
    ("focus", "excited"):  {"session_name": "Grounded Focus",    "technique": "Rhythmic Breathing",     "duration": 10, "message": "Harness your excitement into sharp, grounded focus."},

    # SLEEP + emotion
    ("sleep", "happy"):    {"session_name": "Peaceful Dreams",   "technique": "Body Scan",              "duration": 15, "message": "Carry your happiness into a restful, peaceful sleep."},
    ("sleep", "sad"):      {"session_name": "Night Comfort",     "technique": "Compassion Breathing",   "duration": 20, "message": "Let go of the day's weight and drift into healing sleep."},
    ("sleep", "angry"):    {"session_name": "Night Release",     "technique": "Progressive Relaxation", "duration": 15, "message": "Release the day's tension and prepare for deep sleep."},
    ("sleep", "anxious"):  {"session_name": "Safe Sleep",        "technique": "4-7-8 Breathing",        "duration": 15, "message": "Calm the anxious mind and ease gently into sleep."},
    ("sleep", "neutral"):  {"session_name": "Sleep Drift",       "technique": "Body Scan",              "duration": 15, "message": "A gentle wind-down to prepare your body for rest."},
    ("sleep", "excited"):  {"session_name": "Unwind Mode",       "technique": "Progressive Relaxation", "duration": 15, "message": "Slow down from the day's excitement and ease into sleep."},

    # RELAXATION (calm/happy/mindful goals) + emotion
    ("relaxation", "happy"):   {"session_name": "Gratitude Flow",   "technique": "Gratitude Visualization","duration": 12, "message": "Amplify your joy and cultivate a lasting sense of thankfulness."},
    ("relaxation", "sad"):     {"session_name": "Inner Light",      "technique": "Compassion Breathing",   "duration": 15, "message": "A gentle session to comfort the spirit and find your inner peace."},
    ("relaxation", "angry"):   {"session_name": "Heat Release",     "technique": "Anger Release Breathing","duration": 10, "message": "Release tension and transform frustration into calm awareness."},
    ("relaxation", "anxious"): {"session_name": "Safe Harbor",      "technique": "Box Breathing",          "duration": 8,  "message": "Anchor your mind and calm the nervous system with box breathing."},
    ("relaxation", "neutral"):  {"session_name": "Deep Breath Reset","technique": "Breathing Meditation",  "duration": 5,  "message": "Restore balance with simple, mindful breathing."},
    ("relaxation", "excited"):  {"session_name": "Grounded Energy", "technique": "Rhythmic Breathing",     "duration": 8,  "message": "Channel your excitement into focused, productive calm."},
}

# Emotion-only fallback (if goal not matched)
EMOTION_FALLBACK_MAP = {
    "happy":   {"session_name": "Gratitude Flow",    "technique": "Gratitude Visualization", "duration": 12, "message": "Amplify your joy and cultivate a lasting sense of thankfulness."},
    "sad":     {"session_name": "Inner Light",       "technique": "Compassion Breathing",    "duration": 15, "message": "A gentle session to comfort the spirit and find your inner peace."},
    "angry":   {"session_name": "Heat Release",      "technique": "Anger Release Breathing", "duration": 10, "message": "Release tension and transform frustration into calm awareness."},
    "anxious": {"session_name": "Safe Harbor",       "technique": "Box Breathing",           "duration": 8,  "message": "Anchor your mind and calm the nervous system with box breathing."},
    "neutral": {"session_name": "Deep Breath Reset", "technique": "Breathing Meditation",    "duration": 5,  "message": "Restore balance with simple, mindful breathing."},
    "excited": {"session_name": "Grounded Energy",   "technique": "Rhythmic Breathing",      "duration": 8,  "message": "Channel your excitement into focused, productive calm."},
}


def generate_recommendation(db: Session, goal: str, emotion: str, experience: str):

    try:
        # Normalize inputs
        goal = goal.strip().lower()
        emotion = emotion.strip().lower()
        experience = experience.strip()

        print("INPUTS →", goal, emotion, experience)

        # Map frontend goal → model label
        mapped_goal = GOAL_MAP.get(goal.replace(" ", "_"), "Relaxation")
        mapped_goal_key = mapped_goal.lower()  # "stress relief" → "stress relief", use for lookup

        print("MAPPED GOAL →", mapped_goal)

        # ─── 1. Try AI model prediction ───────────────────────────────
        print("GOAL LABELS →", goal_encoder.classes_)
        print("EMOTION LABELS →", emotion_encoder.classes_)
        print("EXPERIENCE LABELS →", experience_encoder.classes_)

        def match_label(input_value, classes):
            for c in classes:
                if str(input_value).lower() == str(c).lower():
                    return c
            return classes[0]

        matched_goal       = match_label(mapped_goal, goal_encoder.classes_)
        matched_emotion    = match_label(emotion.capitalize(), emotion_encoder.classes_)
        matched_experience = match_label(experience, experience_encoder.classes_)

        print("MATCHED →", matched_goal, matched_emotion, matched_experience)

        g = goal_encoder.transform([matched_goal])[0]
        e = emotion_encoder.transform([matched_emotion])[0]
        x = experience_encoder.transform([matched_experience])[0]

        prediction    = model.predict([[g, e, x]])
        meditation_type = session_encoder.inverse_transform(prediction)[0]

        print("🧠 AI Prediction:", meditation_type)

        # ─── 2. Try DB session ────────────────────────────────────────
        session = get_session_from_db(db, meditation_type)

        if session:
            return {
                "meditation_type": meditation_type,
                "session_name":    session.title,
                "duration":        session.duration,
                "technique":       session.technique,
                "guidance_style":  "Guided",
                "message":         session.description or f"A {session.duration}-minute {meditation_type.lower()} session tailored for you.",
                "match_score":     0.95,
            }

        # ─── 3. Smart map fallback (goal + emotion) ───────────────────
        smart_key = (goal, emotion)                          # e.g. ("stress", "sad")
        # Also try mapped goal key e.g. ("stress relief", "sad")
        smart_key_mapped = (mapped_goal_key, emotion)

        smart = (
            SMART_SESSION_MAP.get(smart_key) or
            SMART_SESSION_MAP.get(smart_key_mapped) or
            EMOTION_FALLBACK_MAP.get(emotion)
        )

        if smart:
            print("✅ Smart map match →", smart_key)
            return {
                "meditation_type": meditation_type,
                "session_name":    smart["session_name"],
                "duration":        smart["duration"],
                "technique":       smart["technique"],
                "guidance_style":  "Guided",
                "message":         smart["message"],
                "match_score":     0.92,
            }

        # ─── 4. Last resort ───────────────────────────────────────────
        return {
            "meditation_type": meditation_type,
            "session_name":    "Mind Balance Session",
            "duration":        10,
            "technique":       "Mindful Breathing",
            "guidance_style":  "Guided",
            "message":         "A balanced session to restore your focus and calm.",
            "match_score":     0.85,
        }

    except Exception as e:
        print("❌ AI ERROR:", e)

        # ─── Exception fallback uses emotion map ──────────────────────
        emotion_key = emotion.strip().lower() if emotion else "neutral"
        fallback    = EMOTION_FALLBACK_MAP.get(emotion_key, EMOTION_FALLBACK_MAP["neutral"])

        return {
            "meditation_type": "Mindfulness Meditation",
            "session_name":    fallback["session_name"],
            "duration":        fallback["duration"],
            "technique":       fallback["technique"],
            "guidance_style":  "Guided",
            "message":         fallback["message"],
            "match_score":     0.80,
        }