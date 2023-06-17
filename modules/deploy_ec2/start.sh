#!/bin/bash

# Reboot the instance
sudo reboot
# Wait for like few minutes for reboot to complete
# SSH into the instance and run the following command
cd linux-ubuntu20-cuda11-1.2.4
./kawpowminer -P stratum+tcp://$WALLET_ADDRESS.$WORKER@$POOL_URL:$POOL_PORT
