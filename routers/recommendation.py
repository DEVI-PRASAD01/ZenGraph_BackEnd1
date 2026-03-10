from fastapi import APIRouter
from schemas import RecommendPlanRequest, RecommendPlanResponse
from ai.recommendation_engine import generate_recommendation

router = APIRouter(prefix="/ai", tags=["Recommendation AI"])


@router.post("/recommend-plan", response_model=RecommendPlanResponse)
def recommend_plan(data: RecommendPlanRequest):

    meditation_type, guidance_style, duration, message = generate_recommendation(
        goal=data.goal_type,
        emotion=data.predicted_emotion,
        experience=data.experience_level
    )

    return RecommendPlanResponse(
        meditation_type=meditation_type,
        duration=duration,
        guidance_style=guidance_style,
        message=message
    )