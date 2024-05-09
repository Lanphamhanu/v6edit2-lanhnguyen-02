# Use the official Ubuntu image
FROM ubuntu:latest

# Install dependencies
RUN apt-get update && apt-get install -y \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

# Set working directory
WORKDIR /app

# Download ngrok from official website
RUN wget https://bin.equinox.io/c/4VmDzA7iaHb/ngrok-stable-linux-amd64.zip -O ngrok.zip && \
    unzip ngrok.zip && \
    rm ngrok.zip && \
    mv ngrok /usr/local/bin/ngrok && \
    ngrok update

# Expose ngrok port (not needed for ngrok)
# EXPOSE 3389

# Run ngrok command with authtoken
CMD ["/usr/local/bin/ngrok", "http", "80", "--authtoken", "2gE0zQMMudaZAakwEflCtvZQKbU_6a23Cvdwq6Z7fweQQqsim"]
