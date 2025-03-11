import json
import subprocess
from fastapi import APIRouter

router = APIRouter()

# Device mapping for easy reference
DEVICE_MAP = {
    "lamp": "0x282c02bfffecf615",
    "boiler": "0x282c02bfffee2361",
    "humidifier": "0x282c02bfffeca298"
}

def send_mqtt_command(device_id: str, state: str):
    """Send MQTT command to Zigbee2MQTT to set device state."""
    command = f'mosquitto_pub -h localhost -t zigbee2mqtt/{device_id}/set -m \'{{"state": "{state.upper()}"}}\''
    subprocess.run(command, shell=True)

@router.post("/toggle/{device}")
def toggle_device(device: str):
    """Toggle a smart plug ON/OFF."""
    if device not in DEVICE_MAP:
        return {"error": "Invalid device name"}
    
    send_mqtt_command(DEVICE_MAP[device], "TOGGLE")
    return {"status": f"Toggled {device}"}

@router.post("/{device}/{state}")
def control_device(device: str, state: str):
    """Turn a device explicitly ON or OFF."""
    if device not in DEVICE_MAP:
        return {"error": "Invalid device name"}
    
    if state.lower() not in ["on", "off"]:
        return {"error": "Invalid state. Use 'on' or 'off'."}
    
    send_mqtt_command(DEVICE_MAP[device], state)
    return {"status": f"Set {device} to {state.upper()}"}

def get_device_status(device_id: str):
    """Fetch the current state of a device using mosquitto_sub."""
    try:
        command = f'mosquitto_sub -h localhost -t zigbee2mqtt/{device_id} -C 1 -v'
        output = subprocess.check_output(command, shell=True, timeout=3).decode().strip()

        # Extract JSON payload (ignore topic name)
        parts = output.split("\n")[-1]  # Take the last line (in case of multi-line response)
        topic, json_payload = parts.split(" ", 1) if " " in parts else ("", "{}")

        data = json.loads(json_payload)
        return {"device": device_id, "state": data.get("state", "UNKNOWN")}

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
    
    return get_device_status(DEVICE_MAP[device])