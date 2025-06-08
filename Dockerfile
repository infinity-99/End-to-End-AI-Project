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

# Create .streamlit directory with proper permissions
RUN mkdir -p /app/.streamlit

# Add basic Streamlit config to suppress warnings and errors
RUN echo "\
[general]\n\
email = \"\"\n\
\n\
[server]\n\
headless = true\n\
enableCORS = false\n\
port = 7860\n\
enableXsrfProtection=false\n\
\n\
[browser]\n\
gatherUsageStats = false\n\
" > /app/.streamlit/config.toml

# Set Streamlit to run your main app
CMD ["streamlit", "run", "app.py", "--server.port=7860", "--server.address=0.0.0.0"]
