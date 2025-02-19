from fastapi import FastAPI
from api.routes import sensors

app = FastAPI(title="Raspberry Pi Smart Home API")

# Include routes
app.include_router(sensors.router, prefix="/sensors")

@app.get("/")
def home():
    return {"message": "Welcome to the Raspberry Pi API!"}
