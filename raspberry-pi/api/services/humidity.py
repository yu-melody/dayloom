import adafruit_dht
import board

# Use GPIO 4 (Pin 7) for data
DHT_SENSOR = adafruit_dht.DHT22(board.D4)

def get_humidity():
    """Reads humidity & temperature from the DHT22 sensor"""
    try:
        temperature = DHT_SENSOR.temperature
        humidity = DHT_SENSOR.humidity

        if humidity is not None and temperature is not None:
            return {"temperature": round(temperature, 1), "humidity": round(humidity, 1)}
        return {"error": "Failed to retrieve data"}

    except RuntimeError as e:
        return {"error": f"Reading from DHT sensor failed: {e}"}

    finally:
        DHT_SENSOR.exit()

