from sqlalchemy.orm import Session
from fastapi import Depends, APIRouter
from database import get_db
from schemas import RecommendPlanRequest, RecommendPlanResponse

from ai.recommendation_engine import generate_recommendation

router = APIRouter(prefix="/ai", tags=["Recommendation AI"])


@router.post("/recommend-plan", response_model=RecommendPlanResponse)
def recommend_plan(data: RecommendPlanRequest, db: Session = Depends(get_db)):

    result = generate_recommendation(
        db=db,
        goal=data.goal_type,
        emotion=data.predicted_emotion,
        experience=data.experience_level
    )

    return RecommendPlanResponse(
        meditation_type=result["meditation_type"],
        session_name=result["session_name"],
        duration=result["duration"],
        technique=result["technique"],
        guidance_style=result["guidance_style"],
        message=result["message"],
        match_score=result["match_score"]
    )