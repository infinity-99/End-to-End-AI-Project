FROM python:3.12-slim

# Set the working directory
WORKDIR /app

# Install dependencies
COPY requirements.txt .
RUN pip install --upgrade pip && pip install -r requirements.txt

# Copy the rest of the app
COPY . .

# FIX: Write config to $HOME/.streamlit, not root or /app
ENV STREAMLIT_HOME=/root

RUN mkdir -p $STREAMLIT_HOME/.streamlit && \
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
" > $STREAMLIT_HOME/.streamlit/config.toml

CMD ["streamlit", "run", "app.py", "--server.port=7860", "--server.address=0.0.0.0"]
