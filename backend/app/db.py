import firebase_admin
from firebase_admin import credentials, firestore

# Initialize Firestore with the service account key
cred = credentials.Certificate("path/to/service-account.json")
firebase_admin.initialize_app(cred)
db = firestore.client()
