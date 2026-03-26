import os
import time
import shutil
from fastapi import APIRouter, Depends, UploadFile, File, Form, HTTPException, Request
from sqlalchemy.orm import Session

from database import get_db
from models import User
from schemas import ProfileResponse, UpdatePreferences

router = APIRouter(prefix="/profile", tags=["Profile"])

UPLOAD_FOLDER = "uploads"

# Ensure upload folder exists
if not os.path.exists(UPLOAD_FOLDER):
    os.makedirs(UPLOAD_FOLDER)


# ================= COMMON UPLOAD FUNCTION =================
def handle_upload(request: Request, user_id: int, file: UploadFile, db: Session):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    # Generate unique filename
    extension = file.filename.split(".")[-1]
    filename = f"profile_{user_id}_{int(time.time())}.{extension}"
    file_path = os.path.join(UPLOAD_FOLDER, filename)

    # Save file
    try:
        with open(file_path, "wb") as buffer:
            shutil.copyfileobj(file.file, buffer)
    except Exception as e:
        raise HTTPException(status_code=500, detail=f"Failed to save file: {str(e)}")

    # Build URL
    base_url = str(request.base_url).rstrip("/")
    file_url = f"{base_url}/uploads/{filename}"

    # Save in DB
    user.profile_image = file_url
    db.commit()
    db.refresh(user)

    return {
        "status": "success",
        "message": "Profile photo uploaded successfully",
        "profile_image": file_url
    }


# ================= UPLOAD PROFILE IMAGE (NEW STANDARD) =================
@router.post("/upload-profile-image")
def upload_profile_image(
    request: Request,
    user_id: int = Form(...),
    file: UploadFile = File(...),
    db: Session = Depends(get_db)
):
    return handle_upload(request, user_id, file, db)


# ================= LEGACY SUPPORT (ANDROID) =================
@router.post("/upload-photo")
def upload_profile_photo(
    request: Request,
    user_id: int = Form(...),
    file: UploadFile = File(...),
    db: Session = Depends(get_db)
):
    return handle_upload(request, user_id, file, db)


# ================= UPDATE PREFERENCES =================
@router.put("/preferences/{user_id}")
def update_preferences(
    user_id: int,
    data: UpdatePreferences,
    db: Session = Depends(get_db)
):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    user.enable_notifications = data.enable_notifications
    user.data_sharing_consent = data.data_sharing_consent

    db.commit()
    db.refresh(user)

    return {
        "status": "success",
        "message": "Preferences updated successfully"
    }


# ================= GET PROFILE =================
@router.get("/{user_id}", response_model=ProfileResponse)
def get_profile(user_id: int, db: Session = Depends(get_db)):
    user = db.query(User).filter(User.id == user_id).first()
    if not user:
        raise HTTPException(status_code=404, detail="User not found")

    return ProfileResponse(
        id=user.id,
        name=user.name,
        email=user.email,
        profile_image=user.profile_image,
        enable_notifications=user.enable_notifications,
        data_sharing_consent=user.data_sharing_consent,
    )