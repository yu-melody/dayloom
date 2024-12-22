# Use a minimal Python base image
FROM python:3.11-slim

# Set the working directory
WORKDIR /app

# Copy application files to the container
COPY . /app

# Install dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Expose the port Cloud Run expects
ENV PORT 8080
EXPOSE 8080

# Run the FastAPI app using Gunicorn and the expected PORT
CMD ["gunicorn", "-w", "4", "-k", "uvicorn.workers.UvicornWorker", "main:app", "--bind", "0.0.0.0:8080"]
