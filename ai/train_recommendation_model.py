import pandas as pd
from sklearn.preprocessing import LabelEncoder
from sklearn.ensemble import RandomForestClassifier
import joblib

# ================= LOAD DATASET =================

df = pd.read_csv("training_data/meditation_dataset.csv")
# ================= ENCODE INPUTS =================

goal_encoder = LabelEncoder()
emotion_encoder = LabelEncoder()
experience_encoder = LabelEncoder()

df["goal"] = goal_encoder.fit_transform(df["goal"])
df["emotion"] = emotion_encoder.fit_transform(df["emotion"])
df["experience"] = experience_encoder.fit_transform(df["experience"])

# ================= ENCODE OUTPUT =================

session_encoder = LabelEncoder()
df["meditation_type"] = session_encoder.fit_transform(df["meditation_type"])

# ================= FEATURES =================

X = df[["goal", "emotion", "experience"]]
y = df["meditation_type"]

# ================= TRAIN MODEL =================

model = RandomForestClassifier(
    n_estimators=500,
    max_depth=20,
    random_state=42
)

model.fit(X, y)

# ================= SAVE =================

joblib.dump(model, "ml_models/recommendation_model.pkl")
joblib.dump(goal_encoder, "ml_models/goal_encoder.pkl")
joblib.dump(emotion_encoder, "ml_models/emotion_encoder.pkl")
joblib.dump(experience_encoder, "ml_models/experience_encoder.pkl")
joblib.dump(session_encoder, "ml_models/session_encoder.pkl")

print("✅ Model + encoders saved successfully!")