# Start from a slim Python 3.10 base image
FROM python:3.10-slim

# Set environment variables
ENV PYTHONUNBUFFERED=True
ENV APP_HOME=/app

# Create and switch to the application directory
WORKDIR $APP_HOME

# Install system dependencies necessary for Chromium & ChromeDriver
RUN apt-get update && apt-get install -y --no-install-recommends \
    chromium \
    chromium-driver \
    # Common libraries needed by Chromium in headless mode
    libnss3 \
    libx11-6 \
    libx11-xcb1 \
    libxcomposite1 \
    libxcursor1 \
    libxdamage1 \
    libxfixes3 \
    libatk-bridge2.0-0 \
    libgtk-3-0 \
    fonts-liberation \
    xdg-utils \
    libxi6 \
    libxrandr2 \
    libxrender1 \
    libxss1 \
    libxtst6 \
    libglib2.0-0 \
    libgbm1 \
    && rm -rf /var/lib/apt/lists/*

# Copy all project files into the container
COPY . ./

# Install Python dependencies
RUN pip install --no-cache-dir -r requirements.txt

# Run main.py and then exit
CMD ["python", "main.py"]