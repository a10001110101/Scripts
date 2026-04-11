#!/bin/bash
#Created        4/10/26
#Modified       XXX

echo "Stopping Ollama..."
sudo systemctl stop ollama

sleep 2
echo "Updating Ollama..."
sudo curl -fsSL https://ollama.com/install.sh | sh

sleep 1
echo "Moving Ollama to /mnt/llmstorage..."
sudo systemctl stop ollama
sudo cp /usr/local/lib/ollama/* /mnt/llmstorage/ollama_runners/ -r
sudo chown -R ollama:ollama /mnt/llmstorage/ollama_runners
sudo rm -rf /usr/local/lib/ollama
sudo ln -s /mnt/llmstorage/ollama_runners /usr/local/lib/ollama

echo "Sanity check. Verify if correct..."
ls -la /mnt/llmstorage/ollama_runners
sleep 5
ls -la /usr/local/lib
sleep 5

echo "Copying service file..."
sudo cp /home/username/ollama-archive/ollama.service.bak /etc/systemd/system/ollama.service
cat /etc/systemd/system/ollama.service
echo "Verify if Environment=OLLAMA_MODELS=/mnt/llmstorage/ollama-models is present"
sleep 5

echo "Starting Ollama..."   
sudo systemctl daemon-reload 
sudo systemctl restart ollama

sleep 2  
sudo docker restart open-webui

echo "Update Open-WebUI if needed after this."
ollama -v
ollama list
