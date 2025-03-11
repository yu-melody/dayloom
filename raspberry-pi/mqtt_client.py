import json
import paho.mqtt.client as mqtt

DEVICE_STATES = {}  # Dictionary to store device states

def on_message(client, userdata, msg):
    """Callback when a message is received."""
    try:
        payload = json.loads(msg.payload.decode())
        DEVICE_STATES[msg.topic] = payload.get("state", "UNKNOWN")
    except json.JSONDecodeError:
        DEVICE_STATES[msg.topic] = "ERROR"

def start_mqtt_listener():
    """Starts the MQTT client in the background."""
    client = mqtt.Client()
    client.on_message = on_message
    client.connect("localhost", 1883, 60)
    client.subscribe("zigbee2mqtt/#")  # Subscribe to all Zigbee devices
    client.loop_start()  # Run MQTT listener in background
