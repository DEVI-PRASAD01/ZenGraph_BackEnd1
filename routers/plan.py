from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database import get_db
from models import AIPlan

router = APIRouter(prefix="/ai", tags=["AI Plan"])


@router.post("/generate-plan")
def generate_plan(data: dict, db: Session = Depends(get_db)):

    goal = data.get("goal", "reduce_stress")
    mood = data.get("mood", "neutral")
    level = data.get("level", "beginner")
    user_id = data.get("user_id")

    if not user_id:
        return {"error": "user_id is required"}

    # ── Duration based on experience level — NOT hardcoded ──
    duration_map = {
        "beginner":     5,
        "intermediate": 10,
        "advanced":     15,
    }
    duration = duration_map.get(str(level).lower(), 5)
    match = 85

    # ── Session title from goal + mood combination ──
    session_map = {
        ("reduce_stress",    "sad"):     "Gentle Healing Flow",
        ("reduce_stress",    "anxious"): "Safe Harbor Session",
        ("reduce_stress",    "angry"):   "Storm to Stillness",
        ("reduce_stress",    "happy"):   "Joyful Stillness",
        ("reduce_stress",    "excited"): "Grounded Energy",
        ("reduce_stress",    "neutral"): "Zen Harmony",
        ("improve_focus",    "sad"):     "Mental Uplift Session",
        ("improve_focus",    "anxious"): "Steady Mind Bridge",
        ("improve_focus",    "angry"):   "Clarity Through Calm",
        ("improve_focus",    "happy"):   "Peak Performance Flow",
        ("improve_focus",    "excited"): "Focus Ignition",
        ("improve_focus",    "neutral"): "Mind Balance Session",
        ("sleep_better",     "sad"):     "Nighttime Comfort",
        ("sleep_better",     "anxious"): "Worry-Free Night",
        ("sleep_better",     "angry"):   "Release & Rest",
        ("sleep_better",     "happy"):   "Peaceful Sunset",
        ("sleep_better",     "excited"): "Soft Landing",
        ("sleep_better",     "neutral"): "Cosmic Calm Journey",
        ("feel_happier",     "sad"):     "Sunrise Within",
        ("feel_happier",     "anxious"): "Calm & Cheerful",
        ("feel_happier",     "angry"):   "Peace & Positivity",
        ("feel_happier",     "happy"):   "Joy Amplifier",
        ("feel_happier",     "excited"): "Radiant Joy Flow",
        ("feel_happier",     "neutral"): "Inner Sunshine",
        ("increase_calm",    "sad"):     "Still Waters",
        ("increase_calm",    "anxious"): "Anchor in the Storm",
        ("increase_calm",    "angry"):   "Fire to Earth",
        ("increase_calm",    "happy"):   "Serene Glow",
        ("increase_calm",    "excited"): "Gentle Descent",
        ("increase_calm",    "neutral"): "Deep Stillness",
        ("build_mindfulness","sad"):     "Compassionate Witness",
        ("build_mindfulness","anxious"): "Present Safety",
        ("build_mindfulness","angry"):   "Mindful Pause",
        ("build_mindfulness","happy"):   "Mindful Joy",
        ("build_mindfulness","excited"): "Mindful Energy",
        ("build_mindfulness","neutral"): "Pure Awareness",
    }

    goal_key = str(goal).lower().replace(" ", "_")
    mood_key = str(mood).lower()
    title = session_map.get((goal_key, mood_key), "Zen Harmony")

    new_plan = AIPlan(
        user_id=user_id,
        goal=goal,
        mood=mood,
        level=level,
        recommended_title=title,
        duration=duration,
        match_percent=match
    )

    db.add(new_plan)
    db.commit()
    db.refresh(new_plan)

    return {
        "status": "success",
        "message": "Plan generated successfully",
        "plan_id": new_plan.id,
        "title": title,
        "duration": duration,
        "match_percent": match
    }