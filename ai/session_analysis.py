def analyze_session(pre_emotion: str, post_mood: str, duration: int):

    improvement_map = {
        ("Stressed", "Calm"): 85,
        ("Sad", "Happy"): 80,
        ("Tense", "Calm"): 75,
        ("Calm", "Calm"): 70,
        ("Happy", "Calm"): 65
    }

    calm_score = improvement_map.get((pre_emotion, post_mood), 60)

    if pre_emotion in ["Stressed", "Tense", "Sad"] and post_mood == "Calm":
        stress_reduction = "High"
        focus_improvement = "High"
    elif pre_emotion == post_mood:
        stress_reduction = "Stable"
        focus_improvement = "Moderate"
    else:
        stress_reduction = "Moderate"
        focus_improvement = "Moderate"

    calm_score += int(duration * 0.5)

    if calm_score > 100:
        calm_score = 100

    return {
        "stress_reduction": stress_reduction,
        "calm_score": calm_score,
        "focus_improvement": focus_improvement
    }