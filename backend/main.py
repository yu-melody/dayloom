from fastapi import FastAPI
from app.config import db
from app.routes.gratitude import router as gratitude_router

app = FastAPI()

app.include_router(gratitude_router, prefix="/gratitude")

@app.get("/")
async def read_root():
    return {"message": "Welcome to Dayloom!"}

@app.get("/test-firestore")
def test_firestore():
    collection_ref = db.collection("test-collection")
    doc_ref = collection_ref.document("test-doc")
    doc_ref.set({"message": "Hello, Firestore!"})
    return {"status": "success"}