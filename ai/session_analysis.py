def analyze_session(pre_emotion: str, post_mood: str, duration: int):

    # Normalize to lowercase to match app data
    pre  = pre_emotion.lower().strip()
    post = post_mood.lower().strip()

    # Complete improvement map — all meaningful combinations
    improvement_map = {
        # Strong positive shifts
        ("angry",   "calm"):    85,
        ("angry",   "relaxed"): 80,
        ("angry",   "focused"): 72,
        ("anxious", "calm"):    83,
        ("anxious", "relaxed"): 78,
        ("anxious", "focused"): 75,
        ("sad",     "happy"):   82,
        ("sad",     "calm"):    78,
        ("sad",     "relaxed"): 74,
        # Neutral shifts
        ("neutral", "calm"):    72,
        ("neutral", "relaxed"): 70,
        ("neutral", "focused"): 68,
        ("neutral", "happy"):   65,
        # Already positive
        ("happy",   "calm"):    70,
        ("happy",   "relaxed"): 72,
        ("happy",   "focused"): 75,
        ("excited", "calm"):    68,
        ("excited", "relaxed"): 70,
        ("excited", "focused"): 73,
        # Same state (no change)
        ("calm",    "calm"):    65,
        ("happy",   "happy"):   63,
        ("neutral", "neutral"): 55,
        ("anxious", "anxious"): 35,
        ("angry",   "angry"):   30,
        ("sad",     "sad"):     28,
    }

    calm_score = improvement_map.get((pre, post), 55)

    # Stress reduction logic
    high_stress_moods    = ["angry", "anxious", "sad"]
    positive_post_moods  = ["calm", "relaxed", "focused", "happy"]

    if pre in high_stress_moods and post in positive_post_moods:
        stress_reduction  = "Significantly Reduced"
        focus_improvement = "High"

    elif pre == post:
        stress_reduction  = "Stable"
        focus_improvement = "Moderate"

    elif post in positive_post_moods:
        stress_reduction  = "Moderate"
        focus_improvement = "Moderate"

    else:
        stress_reduction  = "Slight"
        focus_improvement = "Slight"

    # Duration bonus — meaningful scaling
    if duration >= 20:
        calm_score += 15
    elif duration >= 15:
        calm_score += 10
    elif duration >= 10:
        calm_score += 5
    # under 10 min → no bonus

    # Cap at 100
    calm_score = min(calm_score, 100)

    return {
        "stress_reduction":  stress_reduction,
        "calm_score":        calm_score,
        "focus_improvement": focus_improvement,
        "mood_before":       pre,
        "mood_after":        post,
        "duration_minutes":  duration
    }