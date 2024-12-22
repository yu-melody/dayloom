import os
from firebase_admin import credentials, firestore, initialize_app
from dotenv import load_dotenv

# Load environment variables from .env
load_dotenv()

# Get the path to the service account key from the .env file
SERVICE_ACCOUNT_PATH = os.getenv("GOOGLE_APPLICATION_CREDENTIALS")

if not SERVICE_ACCOUNT_PATH:
    raise ValueError("GOOGLE_APPLICATION_CREDENTIALS is not set in the .env file.")

# Initialize Firebase Admin SDK
cred = credentials.Certificate(SERVICE_ACCOUNT_PATH)
initialize_app(cred)

# Firestore database client
db = firestore.client()

# Export the db object for use in other parts of the application
__all__ = ["db"]
