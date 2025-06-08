FROM python:3.10-slim

# Set a custom, writable home directory
ENV HOME=/app
ENV STREAMLIT_HOME=$HOME

WORKDIR /app

# Copy dependency file and install
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy code
COPY . .

# Create .streamlit config directory in writable home
RUN mkdir -p $HOME/.streamlit && \
    echo "\
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
" > $HOME/.streamlit/config.toml

# Run Streamlit from app.py
CMD ["streamlit", "run", "app.py", "--server.port=7860", "--server.address=0.0.0.0"]
