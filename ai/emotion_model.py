import torch
import torch.nn.functional as F
from transformers import DistilBertTokenizerFast, DistilBertForSequenceClassification

MODEL_PATH = "ml_models/emotion_model"

tokenizer = DistilBertTokenizerFast.from_pretrained(MODEL_PATH)
model = DistilBertForSequenceClassification.from_pretrained(MODEL_PATH)

model.eval()

labels = ['sadness', 'joy', 'love', 'anger', 'fear', 'surprise']

def predict_emotion_model(text: str):
    inputs = tokenizer(text, return_tensors="pt", truncation=True, padding=True)

    with torch.no_grad():
        outputs = model(**inputs)

    logits = outputs.logits
    probabilities = F.softmax(logits, dim=1)

    predicted_class = torch.argmax(probabilities).item()
    confidence = probabilities[0][predicted_class].item()

    return labels[predicted_class], round(confidence, 4)

def predict_emotion(text: str):

    result = classifier(text)[0]

    emotion = result["label"]
    confidence = result["score"]

    return emotion, confidence