import json
import paho.mqtt.client as mqtt

DEVICE_STATES = {}  # Stores latest device states

def on_message(client, userdata, msg):
    """Update device state when a message is received."""
    try:
        payload = json.loads(msg.payload.decode())  # Decode MQTT message
        DEVICE_STATES[msg.topic] = payload.get("state", "UNKNOWN")  # Store state
    except json.JSONDecodeError:
        DEVICE_STATES[msg.topic] = "ERROR"

def start_mqtt_listener():
    """Starts the MQTT listener in the background."""
    client = mqtt.Client()
    client.on_message = on_message
    client.connect("localhost", 1883, 60)  # Connect to MQTT broker
    client.subscribe("zigbee2mqtt/#")  # Subscribe to all Zigbee devices
    client.loop_start()  # Run MQTT in background
