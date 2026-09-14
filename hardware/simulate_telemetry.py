import requests
import time
import random

# The URL of your local FastAPI server
API_URL = "http://127.0.0.1:8000/telemetry"

while True:
    fake_data = {
        "hive_id": 1,
        "weight_kg": round(random.uniform(40.0, 50.0), 2),
        "temperature_c": round(random.uniform(30.0, 36.0), 1)
    }
    
    try:
        response = requests.post(API_URL, json=fake_data)
        print(f"Sent: {fake_data} | Status: {response.status_code}")
    except Exception as e:
        print("Waiting for FastAPI server to start...")
        
    time.sleep(5) # Send new fake data every 5 seconds