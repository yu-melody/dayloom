from fastapi import FastAPI
from app.config import db
from app.routes.gratitude import router as gratitude_router
from app.routes.routines import router as routines_router
from datetime import datetime, time

app = FastAPI()

app.include_router(gratitude_router, prefix="/gratitude")
app.include_router(routines_router, prefix="/routines")

# Initialize Firestore routines if they don't exist
@app.on_event("startup")
async def initialize_routines():
    # Define initial routines
    routines = [
        {
            "id": "39fbc62b-c228-4521-abf0-259a18f16bfd",  # Fixed ID for morning routine
            "name": "Morning Routine",
            "time": datetime.combine(datetime.today(), time(7, 0)),  # Use datetime object directly
            "is_enabled": False,
            "actions": [
                {"type": "alarm", "is_enabled": True},
                {"type": "light", "is_enabled": True},
                {"type": "kettle", "is_enabled": True},
                {"type": "music", "is_enabled": True},
                {"type": "gratitude", "is_enabled": True},
            ],
        },
        {
            "id": "50e141c1-ee05-46e8-9f50-615f315fd508",  # Fixed ID for evening routine
            "name": "Evening Routine",
            "time": datetime.combine(datetime.today(), time(21, 0)),  # Use datetime object directly
            "is_enabled": False,
            "actions": [
                {"type": "alarm", "is_enabled": True},
                {"type": "light", "is_enabled": True},
                {"type": "kettle", "is_enabled": True},
                {"type": "music", "is_enabled": True},
                {"type": "gratitude", "is_enabled": True},
            ],
        },
    ]

    # Check if routines exist, and add them if they don't
    for routine in routines:
        doc_ref = db.collection("routines").document(routine["id"])
        if not doc_ref.get().exists:
            # Firestore will store `time` as a timestamp automatically
            doc_ref.set(routine)
            print(f"Added routine: {routine['name']}")
        else:
            print(f"Routine already exists: {routine['name']}")

@app.get("/")
async def read_root():
    return {"message": "Welcome to Dayloom!"}

@app.get("/test-firestore")
def test_firestore():
    collection_ref = db.collection("test-collection")
    doc_ref = collection_ref.document("test-doc")
    doc_ref.set({"message": "Hello, Firestore!"})
    return {"status": "success"}
