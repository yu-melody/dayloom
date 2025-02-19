from pydantic import BaseModel
from uuid import UUID
from datetime import datetime
from enum import Enum
from typing import List

class RoutineActionType(str, Enum):
    alarm = "alarm"
    light = "light"
    kettle = "kettle"
    music = "music"
    gratitude = "gratitude"

class RoutineAction(BaseModel):
    type: RoutineActionType
    is_enabled: bool

class Routine(BaseModel):
    id: UUID
    name: str
    time: datetime
    is_enabled: bool
    actions: List[RoutineAction]