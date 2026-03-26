import csv
import random

# ---------------- GOALS ----------------
goals = [
    "Reduce Stress",
    "Improve Focus",
    "Sleep Better",
    "Feel Happier",
    "Increase Calm",
    "Build Mindfulness"
]

# ---------------- EMOTIONS ----------------
emotions = [
    "Angry",
    "Sad",
    "Anxious",
    "Happy",
    "Excited",
    "Neutral"
]

# ---------------- EXPERIENCE ----------------
experiences = [
    "Beginner",
    "Intermediate",
    "Advanced"
]

# ---------------- SESSION LIBRARY (120 sessions) ----------------
sessions = [

"Deep Breath Reset","Calm Breathing Journey","Gentle Breath Flow",
"Ocean Breath Awareness","Relaxing Breath Cycle","Breathing Balance",
"Quiet Breath Meditation","Slow Breath Awareness","Peaceful Breathing",
"Breath Energy Reset",

"Present Moment Awareness","Cosmic Calm Journey","Mind Balance Session",
"Still Mind Meditation","Silent Awareness","Thought Observation",
"Clarity Mind Meditation","Inner Awareness","Focused Presence",
"Mindful Stillness",

"Full Body Relaxation","Grounding Body Scan","Deep Release Session",
"Progressive Body Awareness","Muscle Relaxation Scan","Body Calm Flow",
"Inner Body Awareness","Relaxing Body Journey","Tension Release Scan",
"Body Healing Meditation",

"Grateful Heart Practice","Joyful Reflection","Inner Appreciation",
"Daily Gratitude Pause","Gratitude Expansion","Thankful Mind",
"Positive Reflection","Gratitude Awareness","Heartful Gratitude",
"Gratitude Calm",

"Compassion Flow","Kindness Expansion","Heart Opening Session",
"Loving Kindness Practice","Self Compassion Meditation",
"Warm Heart Meditation","Kindness Awareness","Universal Compassion",
"Inner Kindness","Kindness Energy",

"Wind Down Meditation","Deep Sleep Preparation","Nighttime Relaxation",
"Quiet Mind Before Sleep","Sleep Calm Journey","Peaceful Night Meditation",
"Relax Into Sleep","Bedtime Calm","Dream Preparation","Sleep Release",

"Deep Focus Meditation","Creative Clarity Session","Mindful Work",
"Attention Training","Focus Reset","Clarity of Attention",
"Productive Mind","Concentration Practice","Laser Focus Meditation",
"Mind Sharpening",

"Stress Release Meditation","Calm Mind Reset","Emotional Reset",
"Let Go Meditation","Inner Calm Practice","Peaceful Mind Session",
"Stress Recovery","Relax Mind Flow","Release Tension Meditation",
"Calm Energy Flow",

"Anxiety Release Meditation","Calming Awareness","Fear Release Practice",
"Peace Breath Meditation","Emotional Balance Session",
"Safe Mind Meditation","Gentle Calm Meditation","Inner Safety",
"Calm Thought Flow","Grounding Calm",

"Morning Energy Meditation","Refresh Mind Session","Energy Reset",
"Vital Breath Practice","Mind Awakening Meditation","Energy Flow",
"Alertness Meditation","Wake Up Mind","Mind Recharge",
"Focus Energy Boost",

"Self Awareness Meditation","Inner Growth Session","Confidence Meditation",
"Mind Expansion","Personal Clarity","Self Discovery Meditation",
"Mind Development","Growth Reflection","Inner Strength Meditation",
"Self Alignment Meditation",

"Emotional Healing Meditation","Heart Calm Practice","Release Emotion",
"Emotional Clarity Meditation","Healing Mind Session","Inner Peace Healing",
"Compassion Healing","Emotional Balance Meditation","Mind Healing Journey",
"Heart Restoration"
]

rows = []

# ---------------- CREATE BALANCED DATASET ----------------
for goal in goals:
    for emotion in emotions:
        for exp in experiences:

            for i in range(100): # repeat combinations
                session = random.choice(sessions)

                rows.append([
                    goal,
                    emotion,
                    exp,
                    session
                ])

# Shuffle dataset
random.shuffle(rows)

# Save CSV
with open("training_data/recommendation_dataset_10000.csv","w",newline="",encoding="utf-8") as f:

    writer = csv.writer(f)

    writer.writerow([
        "goal",
        "emotion",
        "experience",
        "session_name"
    ])

    writer.writerows(rows)

print("✅ Production dataset created: recommendation_dataset_10000.csv")