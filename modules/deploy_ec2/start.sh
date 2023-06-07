#!/bin/bash

# Add your commands here
cd linux-ubuntu20-cuda11-1.2.4
./kawpowminer -P stratum+tcp://$WALLET_ADDRESS.$WORKER@$POOL_URL:$POOL_PORT
