#!bin/bash
#Created        7/22/2025
#Modified       XXX

#---Configuration---
TARGET_IP="XXX.XXX.XXX.XXX"
PING_TIMEOUT=1
WAIT_BETWEEN_PINGS=3


echo "Sending magic packet..."
wakeonlan XX:XX:XX:XX:XX:XX

echo "Magic packet sent.  Checking if up now..."
while true; ping -c 1 -W $PING_TIMEOUT $TARGET_IP  >/dev/null 2>&1; do
        echo "Still waiting for reply..."
        sleep $WAIT_BETWEEN_PINGS
done

echo "$TARGET_IP is now up..."

echo "Checking for SSH availability..."
while ! timeout 5 bash -c "</dev/tcp/$TARGET_IP/22" 2>/dev/null; do
        echo "SSH not available yet..."
        sleep $WAIT_BETWEEN_PINGS
done

echo "SSH is now available to connect!"
