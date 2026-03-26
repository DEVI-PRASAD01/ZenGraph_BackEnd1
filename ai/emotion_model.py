import torch
import torch.nn.functional as F
from transformers import DistilBertTokenizerFast, DistilBertForSequenceClassification

# ================= MODEL PATH =================
MODEL_PATH = "ml_models/emotion_model"

# ================= LOAD MODEL ONCE =================
tokenizer = DistilBertTokenizerFast.from_pretrained(MODEL_PATH)
model = DistilBertForSequenceClassification.from_pretrained(MODEL_PATH)
model.eval()

# ================= MODEL LABELS =================
# Labels produced by the trained DistilBERT model
labels = ['sadness', 'joy', 'love', 'anger', 'fear', 'surprise']

# ================= UI EMOTION MAPPING =================
# Map model labels → moods used in your UI
emotion_mapping = {
    "sadness": "Sad",
    "joy": "Happy",
    "love": "Happy",
    "anger": "Angry",
    "fear": "Anxious",
    "surprise": "Excited"
}

# ================= EMOTION PREDICTION =================
def predict_emotion(text: str):
    """
    Predict user emotion from text note.
    Returns (emotion, confidence)
    Emotion matches UI moods.
    """

    if not text or len(text.strip()) == 0:
        return "Neutral", 0.0

    inputs = tokenizer(
        text,
        return_tensors="pt",
        truncation=True,
        padding=True
    )

    with torch.no_grad():
        outputs = model(**inputs)

    logits = outputs.logits
    probabilities = F.softmax(logits, dim=1)

    predicted_class = torch.argmax(probabilities).item()
    confidence = probabilities[0][predicted_class].item()

    raw_emotion = labels[predicted_class]
    emotion = emotion_mapping.get(raw_emotion, "Neutral")

    return emotion, round(confidence, 4)