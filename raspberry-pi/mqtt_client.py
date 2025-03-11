import json
import paho.mqtt.client as mqtt

DEVICE_STATES = {}  # Stores latest device states

def on_message(client, userdata, msg):
    """Update device state when a message is received."""
    try:
        payload_str = msg.payload.decode()  # Convert bytes to string
        print(f"DEBUG: Received MQTT message on topic {msg.topic}: {payload_str}")  # Debug log

        # Attempt to parse JSON
        payload = json.loads(payload_str)

        # DEBUG: Print the payload type
        print(f"DEBUG: Payload Type: {type(payload)}, Payload Value: {payload}")

        # If payload is a list, extract the first item
        if isinstance(payload, list) and len(payload) > 0:
            payload = payload[0]  # Assume the first item contains the state

        if isinstance(payload, dict) and "state" in payload:
            DEVICE_STATES[msg.topic] = payload["state"]
        else:
            print(f"WARNING: Unexpected payload format: {payload}")

    except json.JSONDecodeError as e:
        print(f"ERROR: Failed to decode JSON: {e}")
        DEVICE_STATES[msg.topic] = "ERROR: Invalid JSON"


def start_mqtt_listener():
    """Starts the MQTT listener in the background."""
    client = mqtt.Client()
    client.on_message = on_message
    client.connect("localhost", 1883, 60)  # Connect to MQTT broker
    client.subscribe("zigbee2mqtt/#")  # Subscribe to all Zigbee devices
    client.loop_start()  # Run MQTT in background
