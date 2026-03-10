from fastapi import APIRouter
from pydantic import BaseModel
from ai.session_analysis import analyze_session

router = APIRouter(
    prefix="/session-analysis",
    tags=["Session Analysis"]
)

class AnalysisRequest(BaseModel):
    pre_emotion: str
    post_mood: str
    duration: int


@router.post("/analyze")
def analyze(data: AnalysisRequest):

    result = analyze_session(
        data.pre_emotion,
        data.post_mood,
        data.duration
    )

    return result