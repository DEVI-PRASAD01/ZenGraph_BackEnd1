from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text
from pydantic import BaseModel
from datetime import datetime
from database import get_db
from models import User

router = APIRouter(prefix="/chat", tags=["Chat"])


# ================================================================
# SCHEMAS
# ================================================================

class SendMessageRequest(BaseModel):
    sender_id:   int
    receiver_id: int
    message:     str


class MarkReadRequest(BaseModel):
    user_id:   int
    friend_id: int


# ================================================================
# SEND MESSAGE
# ================================================================

@router.post("/send")
def send_message(data: SendMessageRequest, db: Session = Depends(get_db)):
    """POST /chat/send"""
    try:
        if not data.message.strip():
            raise HTTPException(status_code=400, detail="Message cannot be empty")

        db.execute(text(
            "INSERT INTO messages (sender_id, receiver_id, message, is_read) "
            "VALUES (:sender, :receiver, :msg, FALSE)"
        ), {
            "sender":   data.sender_id,
            "receiver": data.receiver_id,
            "msg":      data.message.strip()
        })
        db.commit()

        return {
            "status":  "success",
            "message": "Message sent"
        }
    except HTTPException:
        raise
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))


# ================================================================
# GET CONVERSATION between two users
# ================================================================

@router.get("/messages/{user_id}/{friend_id}")
def get_messages(
    user_id:   int,
    friend_id: int,
    db: Session = Depends(get_db)
):
    """
    GET /chat/messages/{user_id}/{friend_id}
    Returns all messages between two users, oldest first.
    Also marks received messages as read.
    """
    try:
        # Get all messages between both users
        rows = db.execute(text(
            """
            SELECT id, sender_id, receiver_id, message, is_read, created_at
            FROM messages
            WHERE (sender_id = :u AND receiver_id = :f)
               OR (sender_id = :f AND receiver_id = :u)
            ORDER BY created_at ASC
            """
        ), {"u": user_id, "f": friend_id}).fetchall()

        # Mark unread messages as read
        db.execute(text(
            """
            UPDATE messages
            SET is_read = TRUE
            WHERE sender_id = :f AND receiver_id = :u AND is_read = FALSE
            """
        ), {"f": friend_id, "u": user_id})
        db.commit()

        # Get friend info
        friend = db.query(User).filter(User.id == friend_id).first()
        friend_name = friend.name if friend else "Unknown"

        messages = []
        for row in rows:
            # Format time nicely
            try:
                dt = row.created_at
                if isinstance(dt, str):
                    dt = datetime.fromisoformat(dt)
                time_str = dt.strftime("%I:%M %p").lstrip("0").lower()
            except Exception:
                time_str = ""

            messages.append({
                "id":          row.id,
                "sender_id":   row.sender_id,
                "receiver_id": row.receiver_id,
                "message":     row.message,
                "is_read":     row.is_read,
                "time":        time_str,
                "is_mine":     row.sender_id == user_id
            })

        return {
            "status":      "success",
            "friend_name": friend_name,
            "friend_id":   friend_id,
            "messages":    messages
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# ================================================================
# GET UNREAD COUNT for a user
# ================================================================

@router.get("/unread/{user_id}")
def get_unread_count(user_id: int, db: Session = Depends(get_db)):
    """
    GET /chat/unread/{user_id}
    Returns unread message count per friend.
    Used to show red badge on friend cards.
    """
    try:
        rows = db.execute(text(
            """
            SELECT sender_id, COUNT(*) as unread_count
            FROM messages
            WHERE receiver_id = :uid AND is_read = FALSE
            GROUP BY sender_id
            """
        ), {"uid": user_id}).fetchall()

        unread_map = {}
        for row in rows:
            unread_map[str(row.sender_id)] = row.unread_count

        total = sum(unread_map.values())

        return {
            "status":    "success",
            "unread_map": unread_map,
            "total_unread": total
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# ================================================================
# GET CHAT LIST (all friends with last message)
# ================================================================

@router.get("/chat-list/{user_id}")
def get_chat_list(user_id: int, db: Session = Depends(get_db)):
    """
    GET /chat/chat-list/{user_id}
    Returns list of friends with their last message and unread count.
    """
    try:
        rows = db.execute(text(
            """
            SELECT
                u.id          AS friend_id,
                u.name        AS friend_name,
                m.message     AS last_message,
                m.created_at  AS last_time,
                m.sender_id   AS last_sender,
                (
                    SELECT COUNT(*) FROM messages
                    WHERE sender_id = u.id
                      AND receiver_id = :uid
                      AND is_read = FALSE
                ) AS unread_count
            FROM users u
            JOIN friendships f ON (
                (f.user_id = :uid AND f.friend_id = u.id)
            )
            LEFT JOIN messages m ON m.id = (
                SELECT id FROM messages
                WHERE (sender_id = :uid AND receiver_id = u.id)
                   OR (sender_id = u.id AND receiver_id = :uid)
                ORDER BY created_at DESC LIMIT 1
            )
            WHERE f.status = 'accepted'
            ORDER BY m.created_at DESC
            """
        ), {"uid": user_id}).fetchall()

        chat_list = []
        for row in rows:
            name = row.friend_name or "Unknown"
            try:
                dt = row.last_time
                if isinstance(dt, str):
                    dt = datetime.fromisoformat(dt)
                time_str = dt.strftime("%I:%M %p").lstrip("0").lower() if dt else ""
            except Exception:
                time_str = ""

            chat_list.append({
                "friend_id":    row.friend_id,
                "friend_name":  name,
                "initials":     name[:2].upper() if len(name) >= 2 else name.upper(),
                "last_message": row.last_message or "No messages yet",
                "last_time":    time_str,
                "unread_count": row.unread_count or 0,
                "color_index":  (row.friend_id % 5) + 1
            })

        return {
            "status":    "success",
            "chat_list": chat_list
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# ================================================================
# MARK ALL MESSAGES AS READ
# ================================================================

@router.post("/mark-read")
def mark_read(data: MarkReadRequest, db: Session = Depends(get_db)):
    """POST /chat/mark-read"""
    try:
        db.execute(text(
            """
            UPDATE messages
            SET is_read = TRUE
            WHERE sender_id = :f AND receiver_id = :u AND is_read = FALSE
            """
        ), {"f": data.friend_id, "u": data.user_id})
        db.commit()

        return {"status": "success", "message": "Messages marked as read"}

    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))