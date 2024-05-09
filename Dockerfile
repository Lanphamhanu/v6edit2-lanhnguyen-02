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
RUN wget https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-stable-linux-amd64.zip -O ngrok.zip && \
    unzip ngrok.zip && \
    rm ngrok.zip

# Set environment variable for ngrok authtoken
ENV NGROK_AUTH_TOKEN=${NGROK_AUTH_TOKEN}

# Expose ngrok port
EXPOSE 3389

# Run ngrok command
CMD ["./ngrok", "tcp", "3389"]
