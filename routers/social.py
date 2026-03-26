from fastapi import APIRouter, Depends, HTTPException
from sqlalchemy.orm import Session
from sqlalchemy import text
from pydantic import BaseModel
from datetime import datetime, timedelta
from database import get_db
from models import User, MeditationSession

router = APIRouter(prefix="/social", tags=["Social"])


# ================================================================
# SCHEMAS
# ================================================================

class AddFriendRequest(BaseModel):
    user_id:   int
    friend_id: int

class NudgeRequest(BaseModel):
    user_id:   int
    friend_id: int

class JoinChallengeRequest(BaseModel):
    challenge_id: int
    user_id:      int


# ================================================================
# HELPER — calculate streak for any user
# ================================================================

def calculate_streak(uid: int, db: Session) -> dict:
    try:
        sessions = db.query(MeditationSession).filter(
            MeditationSession.user_id == uid,
            MeditationSession.status == "completed",
            MeditationSession.completed_at != None
        ).order_by(MeditationSession.completed_at.desc()).all()

        streak = 0
        today = datetime.utcnow().date()
        meditated_today = False

        # Build set of dates that have completed sessions
        completed_dates = set()
        for s in sessions:
            if s.completed_at:
                try:
                    completed_dates.add(s.completed_at.date())
                except Exception:
                    pass

        # Count consecutive days backwards from today
        for i in range(30):
            check_date = today - timedelta(days=i)
            if check_date in completed_dates:
                streak += 1
                if i == 0:
                    meditated_today = True
            else:
                if i > 0:
                    break

        return {
            "streak": streak,
            "meditated_today": meditated_today,
            "total_sessions": len(sessions)
        }
    except Exception as e:
        return {
            "streak": 0,
            "meditated_today": False,
            "total_sessions": 0
        }


# ================================================================
# FRIEND STREAKS
# ================================================================

@router.post("/add-friend")
def add_friend(data: AddFriendRequest, db: Session = Depends(get_db)):
    try:
        if data.user_id == data.friend_id:
            return {"status": "error", "message": "Cannot add yourself"}

        existing = db.execute(text(
            "SELECT id FROM friendships WHERE user_id=:u AND friend_id=:f"
        ), {"u": data.user_id, "f": data.friend_id}).fetchone()

        if existing:
            return {"status": "already_friends", "message": "Already friends"}

        friend = db.query(User).filter(User.id == data.friend_id).first()
        if not friend:
            raise HTTPException(status_code=404, detail="User not found")

        db.execute(text(
            "INSERT INTO friendships (user_id, friend_id, status) "
            "VALUES (:u, :f, 'accepted')"
        ), {"u": data.user_id, "f": data.friend_id})

        db.execute(text(
            "INSERT INTO friendships (user_id, friend_id, status) "
            "VALUES (:f, :u, 'accepted')"
        ), {"u": data.user_id, "f": data.friend_id})

        db.commit()
        return {
            "status": "success",
            "message": f"You are now friends with {friend.name}"
        }
    except HTTPException:
        raise
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/friend-streaks/{user_id}")
def get_friend_streaks(user_id: int, db: Session = Depends(get_db)):
    try:
        user = db.query(User).filter(User.id == user_id).first()
        if not user:
            raise HTTPException(status_code=404, detail="User not found")

        user_data = calculate_streak(user_id, db)

        result = [{
            "user_id":         user_id,
            "name":            user.name,
            "initials":        user.name[:2].upper() if len(user.name) >= 2 else user.name.upper(),
            "streak":          user_data["streak"],
            "meditated_today": user_data["meditated_today"],
            "total_sessions":  user_data["total_sessions"],
            "is_self":         True,
            "color_index":     0
        }]

        friends_rows = db.execute(text(
            """
            SELECT u.id, u.name FROM users u
            JOIN friendships f ON f.friend_id = u.id
            WHERE f.user_id = :uid AND f.status = 'accepted'
            ORDER BY u.name ASC
            """
        ), {"uid": user_id}).fetchall()

        for row in friends_rows:
            fdata = calculate_streak(row.id, db)
            name = row.name or "Unknown"
            result.append({
                "user_id":         row.id,
                "name":            name,
                "initials":        name[:2].upper() if len(name) >= 2 else name.upper(),
                "streak":          fdata["streak"],
                "meditated_today": fdata["meditated_today"],
                "total_sessions":  fdata["total_sessions"],
                "is_self":         False,
                "color_index":     (row.id % 5) + 1
            })

        self_entry = [x for x in result if x["is_self"]]
        others     = sorted(
            [x for x in result if not x["is_self"]],
            key=lambda x: x["streak"],
            reverse=True
        )

        return {
            "status":        "success",
            "total_friends": len(friends_rows),
            "friends":       self_entry + others
        }

    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/find-user")
def find_user(
    name: str,
    current_user_id: int = 0,
    db: Session = Depends(get_db)
):
    try:
        users = db.query(User).filter(
            User.name.ilike(f"%{name}%"),
            User.id != current_user_id
        ).limit(10).all()

        return {
            "status": "success",
            "users": [
                {
                    "user_id":     u.id,
                    "name":        u.name,
                    "initials":    u.name[:2].upper() if len(u.name) >= 2 else u.name.upper(),
                    "color_index": (u.id % 5) + 1
                }
                for u in users
            ]
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/nudge")
def nudge_friend(data: NudgeRequest, db: Session = Depends(get_db)):
    try:
        friend = db.query(User).filter(User.id == data.friend_id).first()
        if not friend:
            raise HTTPException(status_code=404, detail="Friend not found")

        sender      = db.query(User).filter(User.id == data.user_id).first()
        sender_name = sender.name if sender else "Someone"

        return {
            "status":  "success",
            "message": f"Nudge sent to {friend.name} from {sender_name}"
        }
    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


# ================================================================
# COMMUNITY CHALLENGES
# ================================================================

@router.get("/current-challenge")
def get_current_challenge(db: Session = Depends(get_db)):
    try:
        today = datetime.utcnow().date()

        row = db.execute(text(
            """
            SELECT id, title, description, target_days, week_start, week_end
            FROM challenges
            WHERE week_start <= :today AND week_end >= :today
            ORDER BY id DESC LIMIT 1
            """
        ), {"today": today}).fetchone()

        if not row:
            return {"status": "no_challenge", "challenge": None}

        count_row = db.execute(text(
            "SELECT COUNT(*) as total FROM challenge_participants "
            "WHERE challenge_id=:cid"
        ), {"cid": row.id}).fetchone()

        total = count_row.total if count_row else 0

        return {
            "status": "success",
            "challenge": {
                "id":                 row.id,
                "title":              row.title,
                "description":        row.description or "",
                "target_days":        row.target_days,
                "week_start":         str(row.week_start),
                "week_end":           str(row.week_end),
                "total_participants": total
            }
        }
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.post("/join-challenge")
def join_challenge(data: JoinChallengeRequest, db: Session = Depends(get_db)):
    try:
        existing = db.execute(text(
            "SELECT id FROM challenge_participants "
            "WHERE challenge_id=:cid AND user_id=:uid"
        ), {"cid": data.challenge_id, "uid": data.user_id}).fetchone()

        if existing:
            return {"status": "already_joined", "message": "Already in challenge"}

        db.execute(text(
            "INSERT INTO challenge_participants "
            "(challenge_id, user_id, days_completed) VALUES (:cid, :uid, 0)"
        ), {"cid": data.challenge_id, "uid": data.user_id})
        db.commit()

        return {"status": "success", "message": "Joined challenge! Keep meditating."}
    except Exception as e:
        db.rollback()
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/leaderboard/{challenge_id}")
def get_leaderboard(challenge_id: int, db: Session = Depends(get_db)):
    try:
        challenge_row = db.execute(text(
            "SELECT week_start, week_end, target_days "
            "FROM challenges WHERE id=:cid"
        ), {"cid": challenge_id}).fetchone()

        if not challenge_row:
            raise HTTPException(status_code=404, detail="Challenge not found")

        participants = db.execute(text(
            """
            SELECT cp.user_id, u.name
            FROM challenge_participants cp
            JOIN users u ON u.id = cp.user_id
            WHERE cp.challenge_id = :cid
            """
        ), {"cid": challenge_id}).fetchall()

        leaderboard = []
        for p in participants:
            try:
                days_row = db.execute(text(
                    """
                    SELECT COUNT(DISTINCT DATE(completed_at)) as days
                    FROM meditation_sessions
                    WHERE user_id   = :uid
                      AND status    = 'completed'
                      AND completed_at IS NOT NULL
                      AND DATE(completed_at) BETWEEN :ws AND :we
                    """
                ), {
                    "uid": p.user_id,
                    "ws":  challenge_row.week_start,
                    "we":  challenge_row.week_end
                }).fetchone()

                days = days_row.days if days_row and days_row.days else 0
                name = p.name or "Unknown"

                leaderboard.append({
                    "user_id":             p.user_id,
                    "name":                name,
                    "initials":            name[:2].upper() if len(name) >= 2 else name.upper(),
                    "days_completed":      days,
                    "target_days":         challenge_row.target_days,
                    "completed_challenge": days >= challenge_row.target_days,
                    "color_index":         (p.user_id % 5) + 1
                })
            except Exception:
                continue

        leaderboard.sort(key=lambda x: x["days_completed"], reverse=True)
        for i, entry in enumerate(leaderboard):
            entry["rank"] = i + 1

        return {"status": "success", "leaderboard": leaderboard[:20]}

    except HTTPException:
        raise
    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))


@router.get("/my-challenge-progress/{user_id}")
def my_challenge_progress(user_id: int, db: Session = Depends(get_db)):
    try:
        today = datetime.utcnow().date()

        challenge = db.execute(text(
            """
            SELECT id, target_days, week_start, week_end
            FROM challenges
            WHERE week_start <= :today AND week_end >= :today
            ORDER BY id DESC LIMIT 1
            """
        ), {"today": today}).fetchone()

        if not challenge:
            return {
                "status":           "no_challenge",
                "days_completed":   0,
                "target_days":      5,
                "is_joined":        False,
                "progress_percent": 0,
                "challenge_id":     0
            }

        days_row = db.execute(text(
            """
            SELECT COUNT(DISTINCT DATE(completed_at)) as days
            FROM meditation_sessions
            WHERE user_id      = :uid
              AND status       = 'completed'
              AND completed_at IS NOT NULL
              AND DATE(completed_at) BETWEEN :ws AND :we
            """
        ), {
            "uid": user_id,
            "ws":  challenge.week_start,
            "we":  challenge.week_end
        }).fetchone()

        days   = days_row.days if days_row and days_row.days else 0
        joined = db.execute(text(
            "SELECT id FROM challenge_participants "
            "WHERE challenge_id=:cid AND user_id=:uid"
        ), {"cid": challenge.id, "uid": user_id}).fetchone()

        percent = round(
            (days / challenge.target_days) * 100
        ) if challenge.target_days > 0 else 0

        return {
            "status":           "success",
            "challenge_id":     challenge.id,
            "days_completed":   days,
            "target_days":      challenge.target_days,
            "is_joined":        joined is not None,
            "progress_percent": percent
        }

    except Exception as e:
        raise HTTPException(status_code=500, detail=str(e))