import Adafruit_DHT

DHT_SENSOR = Adafruit_DHT.DHT22
DHT_PIN = 4 

def get_humidity():
    """Reads humidity & temperature from the DHT22 sensor"""
    humidity, temperature = Adafruit_DHT.read_retry(DHT_SENSOR, DHT_PIN)
    if humidity is not None and temperature is not None:
        return {"temperature": round(temperature, 1), "humidity": round(humidity, 1)}
    return {"error": "Failed to retrieve data"}