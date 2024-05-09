# Use the official Windows Server Core image
FROM mcr.microsoft.com/windows/servercore:ltsc2019

# Set working directory
WORKDIR /app

# Download and install ngrok
RUN powershell -Command \
    Invoke-WebRequest https://bin.equinox.io/c/bNyj1mQVY4c/ngrok-v3-stable-windows-amd64.zip -OutFile ngrok.zip; \
    Expand-Archive ngrok.zip -DestinationPath ngrok; \
    Remove-Item ngrok.zip

# Set environment variable for ngrok authtoken
ENV NGROK_AUTH_TOKEN=${NGROK_AUTH_TOKEN}

# Enable Terminal Services
RUN powershell -Command \
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server' -name "fDenyTSConnections" -Value 0; \
    Enable-NetFirewallRule -DisplayGroup "Remote Desktop"; \
    Set-ItemProperty -Path 'HKLM:\System\CurrentControlSet\Control\Terminal Server\WinStations\RDP-Tcp' -name "UserAuthentication" -Value 1; \
    New-LocalUser -Name "runneradmin" -Password (ConvertTo-SecureString -AsPlainText "P@ssw0rd!" -Force)

# Expose ngrok port
EXPOSE 3389

# Run ngrok command
CMD ["powershell", "-Command", "$startTime = Get-Date; $maxDuration = (New-TimeSpan -Hours 5 -Minutes 55).TotalSeconds; do { .\\ngrok\\ngrok.exe tcp 3389; $currentTime = Get-Date; $duration = New-TimeSpan -Start $startTime -End $currentTime; if ($duration.TotalSeconds -ge $maxDuration) { Write-Host 'Maximum execution time reached. Exiting script.'; break; } } until ($false)"]
