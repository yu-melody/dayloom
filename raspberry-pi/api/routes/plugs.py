import json
from fastapi import APIRouter
import subprocess

router = APIRouter()

# Device mapping for easy reference
# from http://10.110.116.249:8080
DEVICE_MAP = {
    "lamp": "0x282c02bfffecf615",  # Replace with your actual device ID
    "boiler": "0x282c02bfffee2361",
    "humidifier": "0x282c02bfffeca298"
}

def toggle_plug(device_id: str, state: str):
    """Send MQTT command to Zigbee2MQTT to turn device on/off."""
    command = f'mosquitto_pub -h localhost -t zigbee2mqtt/{device_id}/set -m \'{{"state": "{state.upper()}"}}\''
    subprocess.run(command, shell=True)

@router.post("/toggle/{device}")
def toggle_device(device: str):
    """Toggle a smart plug on/off."""
    if device not in DEVICE_MAP:
        return {"error": "Invalid device name"}
    
    toggle_plug(DEVICE_MAP[device], "TOGGLE")
    return {"status": f"Toggled {device}"}

@router.post("/{device}/{state}")
def control_device(device: str, state: str):
    """Explicitly turn a device on or off."""
    if device not in DEVICE_MAP:
        return {"error": "Invalid device name"}
    
    if state.lower() not in ["on", "off"]:
        return {"error": "Invalid state. Use 'on' or 'off'."}
    
    toggle_plug(DEVICE_MAP[device], state)
    return {"status": f"Set {device} to {state.upper()}"}

def get_device_status(device_id: str):
    """Fetch the current state of a device using mosquitto_sub (blocking)."""
    try:
        command = f'mosquitto_sub -h localhost -t zigbee2mqtt/{device_id} -C 1'
        output = subprocess.check_output(command, shell=True, timeout=3).decode().strip()

        # Extract only the JSON part (ignore topic name)
        parts = output.split(" ", 1)
        json_payload = parts[1] if len(parts) > 1 else "{}"

        data = json.loads(json_payload)
        return data.get("state", "UNKNOWN")  # Return state or "UNKNOWN" if missing

    except subprocess.TimeoutExpired:
        return {"device": device_id, "state": "TIMEOUT"}
    except json.JSONDecodeError:
        return {"device": device_id, "state": "ERROR: Invalid JSON"}
    except Exception as e:
        return {"device": device_id, "state": f"Error: {str(e)}"}

@router.get("/status/{device}")
def device_status(device: str):
    """Fetch the status of a smart plug."""
    if device not in DEVICE_MAP:
        return {"error": "Invalid device name"}
    
    state = get_device_status(DEVICE_MAP[device])
    return {"device": device, "state": state}