from fastapi import FastAPI
from api.routes import sensors, plugs
from mqtt_client import start_mqtt_listener, DEVICE_STATES 

app = FastAPI(title="Raspberry Pi Smart Home API")

start_mqtt_listener()

@app.get("/status/{device}")
def get_device_status(device: str):
    """Fetch the current state of a device."""
    topic = f"zigbee2mqtt/{device}"
    return {"device": device, "state": DEVICE_STATES.get(topic, "UNKNOWN")}

app.include_router(sensors.router, prefix="/sensors")
app.include_router(plugs.router, prefix="/plugs")

@app.get("/")
def home():
    return {"message": "Welcome to the Raspberry Pi API!"}
