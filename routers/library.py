from fastapi import APIRouter

router = APIRouter(
    prefix="/library",
    tags=["Meditation Library"]
)

sessions = [
    {
        "id": 1,
        "title": "Breathe & Release",
        "category": "Anxiety Relief",
        "duration": 5
    },
    {
        "id": 2,
        "title": "Morning Focus",
        "category": "Deep Focus",
        "duration": 10
    },
    {
        "id": 3,
        "title": "Deep Relaxation",
        "category": "Sleep",
        "duration": 20
    },
    {
        "id": 4,
        "title": "Stress Reset",
        "category": "Anxiety Relief",
        "duration": 8
    },
    {
        "id": 5,
        "title": "Micro Calm",
        "category": "Quick Calm",
        "duration": 3
    },
    {
        "id": 6,
        "title": "Mindful Walk",
        "category": "Deep Focus",
        "duration": 15
    }
]


@router.get("/sessions")
def get_sessions():
    return sessions