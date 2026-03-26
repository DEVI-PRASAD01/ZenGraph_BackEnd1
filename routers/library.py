from fastapi import APIRouter, Depends
from sqlalchemy.orm import Session
from database import get_db
from models import MeditationLibrary

router = APIRouter(
    prefix="/library",
    tags=["Meditation Library"]
)


@router.get("/sessions")
def get_sessions(db: Session = Depends(get_db)):
    return db.query(MeditationLibrary).all()