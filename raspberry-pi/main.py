from fastapi import FastAPI
from api.routes import sensors, plugs

app = FastAPI(title="Raspberry Pi Smart Home API")

# Include routes
app.include_router(sensors.router, prefix="/sensors")
app.include_router(plugs.router, prefix="/plugs")

@app.get("/")
def home():
    return {"message": "Welcome to the Raspberry Pi API!"}
