from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database import get_db
from models import AIPlan

router = APIRouter(prefix="/ai", tags=["AI Plan"])


@router.post("/generate-plan")
def generate_plan(data: dict, db: Session = Depends(get_db)):

    goal = data.get("goal")
    mood = data.get("mood")
    level = data.get("level")
    user_id = data.get("user_id")

    if not user_id:
        return {"error": "user_id is required"}

    # Simple AI logic (temporary)
    if mood.lower() in ["sad", "anxious"]:
        title = "Cosmic Calm Journey"
        duration = 15
        match = 85
    else:
        title = "Mind Balance Session"
        duration = 10
        match = 75

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