from fastapi import APIRouter, HTTPException
from app.models.gratitude import GratitudeEntry
from app.config import db  # Import Firestore client
from uuid import UUID
from typing import List
from datetime import datetime

router = APIRouter()

# Firestore collection reference
collection_name = "gratitude_entries"

@router.get("/", response_model=List[GratitudeEntry])
def get_gratitude_entries():
    # Fetch all entries from Firestore
    entries_ref = db.collection(collection_name).stream()
    entries = [GratitudeEntry(**doc.to_dict()) for doc in entries_ref]
    return entries

@router.get("/{entry_id}", response_model=GratitudeEntry)
def get_gratitude_entry(entry_id: UUID):
    # Fetch a single entry by ID
    doc_ref = db.collection(collection_name).document(str(entry_id))
    doc = doc_ref.get()
    if doc.exists:
        return GratitudeEntry(**doc.to_dict())
    raise HTTPException(status_code=404, detail="Gratitude entry not found")

@router.post("/", response_model=GratitudeEntry)
def add_gratitude_entry(entry: GratitudeEntry):
    # Set the date to the current UTC time if it's not provided
    if not entry.date:
        entry.date = datetime.combine(datetime.utcnow().date())

    # Convert UUID to string
    entry_dict = entry.dict(exclude_none=True)
    entry_dict["id"] = str(entry_dict["id"])  # Convert UUID to string

    # Save the entry to Firestore
    doc_ref = db.collection(collection_name).document(entry_dict["id"])
    doc_ref.set(entry_dict)
    return entry

@router.put("/{entry_id}", response_model=GratitudeEntry)
def update_gratitude_entry(entry_id: UUID, entry: GratitudeEntry):
    # Convert UUID to string for Firestore
    entry_id_str = str(entry_id)

    # Get the Firestore document reference
    doc_ref = db.collection(collection_name).document(entry_id_str)

    # Check if the document exists
    doc = doc_ref.get()
    if not doc.exists:
        raise HTTPException(status_code=404, detail="Gratitude entry not found")

    # Convert the entry data to a Firestore-compatible format
    entry_dict = entry.dict(exclude_none=True)
    entry_dict["id"] = entry_id_str  # Ensure the id is a string

    # Update the Firestore document
    doc_ref.set(entry_dict)
    return entry


@router.delete("/{entry_id}", response_model = dict)
def delete_gratitude_entry(entry_id: UUID):
    # Delete an entry from Firestore
    doc_ref = db.collection(collection_name).document(str(entry_id))
    doc = doc_ref.get()
    if doc.exists:
        doc_ref.delete()
        return {"message": "Entry deleted"}
    raise HTTPException(status_code=404, detail="Gratitude entry not found")