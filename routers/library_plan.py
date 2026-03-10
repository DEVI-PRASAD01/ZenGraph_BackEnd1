from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database import get_db
from models import AIPlan

router = APIRouter(
    prefix="/library",
    tags=["Library"]
)

@router.post("/generate-plan")
def generate_library_plan(data: dict, db: Session = Depends(get_db)):

    user_id = data.get("user_id")
    title = data.get("title")
    duration = data.get("duration")
    category = data.get("category")

    new_plan = AIPlan(
        user_id=user_id,
        goal=category,
        mood="Library",
        level="General",
        recommended_title=title,
        duration=duration,
        match_percent=100
    )

    db.add(new_plan)
    db.commit()
    db.refresh(new_plan)

    return {
        "plan_id": new_plan.id,
        "title": new_plan.recommended_title,
        "duration": new_plan.duration,
        "goal": new_plan.goal,
        "match_percent": new_plan.match_percent
    }