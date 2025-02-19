import adafruit_dht
import board

# Use GPIO 4 (Pin 7) for data
DHT_SENSOR = adafruit_dht.DHT22(board.D4)

try:
    temperature = DHT_SENSOR.temperature
    humidity = DHT_SENSOR.humidity

    if humidity is not None and temperature is not None:
        print(f"Temperature: {temperature:.1f}°C")
        print(f"Humidity: {humidity:.1f}%")
    else:
        print("Failed to retrieve data from humidity sensor")

except RuntimeError as e:
    print(f"Reading from DHT sensor failed: {e}")

finally:
    DHT_SENSOR.exit()

