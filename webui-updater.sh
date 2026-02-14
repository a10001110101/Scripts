#!/bin/bash
#Created        2/13/2026
#Modified       XXX

echo "Stopping Open-WebUI..."
sudo docker stop open-webui

sleep 2
echo "Removing old Open-WebUI instance..."
sudo docker rm -f open-webui

sleep 2
echo "Updating Open-WebUI..."
sudo docker pull ghcr.io/open-webui/open-webui:main

sleep 2
echo "Configuring Open-WebUI..."
sudo docker run -d --name open-webui --network=host -v open-webui:/app/backend/data -e OLLAMA_API_BASE_URL=http://localhost:11434 --restart always ghcr.io/open-webui/open-webui:main

sleep 2
echo "Starting Open-WebUI..."
sudo docker restart open-webui

sleep 2
echo "Check Open-WebUI is running."
