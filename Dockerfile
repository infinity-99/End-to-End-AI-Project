# Use Python base image
FROM python:3.12-slim

# Set working directory inside container
WORKDIR /app

# Copy dependency file first for Docker cache
COPY requirements.txt .

# Install dependencies
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy all files
COPY . .

# Set Streamlit to run your main app
CMD ["streamlit", "run", "app.py", "--server.port=7860", "--server.address=0.0.0.0"]
