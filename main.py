from fastapi import FastAPI, Request
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from fastapi.exceptions import RequestValidationError
from fastapi.responses import JSONResponse

from routers import library
from routers import library_plan
from routers import coach
from routers import social
from routers import chat 

from database import engine, Base

from routers import (
    auth,
    session,
    analytics,
    profile,
    plan,
    recommendation,
    emotion,
    session_analysis
)

import os

Base.metadata.create_all(bind=engine)

app = FastAPI(
    title="ZenGraph API",
    version="1.0.0"
)

# ✅ ADDED: CLEAN VALIDATION ERROR HANDLER
@app.exception_handler(RequestValidationError)
async def validation_exception_handler(request: Request, exc: RequestValidationError):
    error_message = exc.errors()[0]["msg"]
    return JSONResponse(
        status_code=400,
        content={"message": error_message}
    )

app.add_middleware(
    CORSMiddleware,
    allow_origins=["http://localhost:5173", "http://127.0.0.1:5173", "http://localhost:3000", "http://localhost:5174"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

UPLOAD_FOLDER = "uploads"
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

app.mount(
    "/uploads",
    StaticFiles(directory=UPLOAD_FOLDER),
    name="uploads"
)

app.include_router(auth.router)
app.include_router(emotion.router)
app.include_router(recommendation.router)
app.include_router(plan.router)
app.include_router(session.router)
app.include_router(analytics.router)
app.include_router(profile.router)
app.include_router(session_analysis.router)
app.include_router(library.router)
app.include_router(library_plan.router)
app.include_router(coach.router)
app.include_router(social.router)
app.include_router(chat.router)

@app.get("/")
def root():
    return {"message": "ZenGraph API is running successfully"}