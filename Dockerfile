# Use the official Ubuntu image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Download and install ngrok
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -O ngrok.zip && \
    unzip ngrok.zip && \
    rm ngrok.zip

# Set environment variable for ngrok authtoken
ENV NGROK_AUTH_TOKEN=${NGROK_AUTH_TOKEN}

# Expose ngrok port (not needed for ngrok)
# EXPOSE 3389

# Run ngrok command with authtoken
CMD ["./ngrok", "http", "80", "--authtoken", "${NGROK_AUTH_TOKEN}"]
