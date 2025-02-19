from fastapi import APIRouter
from api.services.humidity import get_humidity

router = APIRouter()

@router.get("/humidity")
def humidity_data():
    return get_humidity()
