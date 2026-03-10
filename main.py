from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from fastapi.staticfiles import StaticFiles
from routers import library
from routers import library_plan
from routers import coach

from database import engine, Base

# Routers
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

# ==============================
# Create Database Tables
# ==============================
Base.metadata.create_all(bind=engine)

# ==============================
# Create FastAPI App
# ==============================
app = FastAPI(
    title="ZenGraph API",
    version="1.0.0"
)

# ==============================
# CORS Configuration
# ==============================
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# ==============================
# Static Files
# ==============================
UPLOAD_FOLDER = "uploads"

if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)

app.mount(
    "/uploads",
    StaticFiles(directory=UPLOAD_FOLDER),
    name="uploads"
)

# ==============================
# Include Routers
# ==============================

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

# ==============================
# Root Endpoint
# ==============================
@app.get("/")
def root():
    return {"message": "ZenGraph API is running successfully"}