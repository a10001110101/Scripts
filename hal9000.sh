#!/bin/bash/
#Created        7/22/2025
#Modified       XXX

#---Configuration---
TARGET_IP="XXX.XXX.XXX.XXX"
WAIT_BETWEEN_PINGS=3

echo "Checking for SSH on HAL9000..."
while ! timeout 5 bash -c "</dev/tcp/$TARGET_IP/22" 2>/dev/null; do
        echo "SSH not available yet..."
        sleep $WAIT_BETWEEN_PINGS
done

echo "SSH is available on HAL9000.  Connecting..."
ssh USERNAME@XXX.XXX.XXX.XXX
