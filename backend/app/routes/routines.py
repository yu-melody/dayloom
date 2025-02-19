from fastapi import APIRouter, HTTPException
from app.models.routine import Routine
from app.config import db  # Import Firestore client
from uuid import UUID
from typing import List
from datetime import datetime

router = APIRouter()

# Firestore collection reference
collection_name = "routines"

# gets the routine data
@router.get("/", response_model=List[Routine])
def get_routines():
    routines_ref = db.collection(collection_name).stream()
    routines = []
    for doc in routines_ref:
        data = doc.to_dict()
        if isinstance(data['time'], datetime):
            data['time'] = data['time'].isoformat()  # Convert to ISO 8601 string
        routines.append(Routine(**data))
    return routines

# updates the routine data
@router.put("/{routine_id}", response_model=Routine)
def update_routine(routine_id: UUID, routine: Routine):
    # Convert UUID to string for Firestore
    routine_id_str = str(routine_id)

    # Get the Firestore document reference
    doc_ref = db.collection(collection_name).document(routine_id_str)

    # Check if the document exists
    doc = doc_ref.get()
    if not doc.exists:
        raise HTTPException(status_code=404, detail="Routine not found")

    # Convert the entry data to a Firestore-compatible format
    routine_dict = routine.dict(exclude_none=True)
    routine_dict["id"] = routine_id_str  # Ensure the id is a string

    # Update the Firestore document
    doc_ref.set(routine_dict)
    return routine