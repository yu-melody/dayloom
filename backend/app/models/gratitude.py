from pydantic import BaseModel
from uuid import UUID
from datetime import datetime

class GratitudeEntry(BaseModel):
    id: UUID
    text: str
    date: datetime

    class Config:
        # Serialize datetime as simplified ISO8601 without microseconds
        json_encoders = {
            datetime: lambda v: v.strftime('%Y-%m-%dT%H:%M:%SZ')  # Simplified ISO8601 format
        }
