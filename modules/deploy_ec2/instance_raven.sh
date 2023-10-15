#!/bin/bash
_user=ubuntu
_wallet_address="${wallet_address}"
_worker="${worker}"
_pool_url="${pool_url}"
_pool_port="${pool_port}"

wget https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/cuda-ubuntu2004.pin
sudo mv cuda-ubuntu2004.pin /etc/apt/preferences.d/cuda-repository-pin-600
sudo apt-key adv --fetch-keys https://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/3bf863cc.pub
sudo add-apt-repository "deb http://developer.download.nvidia.com/compute/cuda/repos/ubuntu2004/x86_64/ /"
sudo apt update
sudo apt install cuda-toolkit-11-2 -y
sudo add-apt-repository ppa:graphics-drivers/ppa --yes
sudo apt update
sudo apt install nvidia-driver-470 -y
wget --load-cookies /tmp/cookies.txt "https://docs.google.com/uc?export=download&confirm=$(wget --quiet --save-cookies /tmp/cookies.txt --keep-session-cookies --no-check-certificate 'https://docs.google.com/uc?export=download&id=16GGf9-1rdwPHKAlRYLbNaPL7rEY7mM7m' -O- | sed -rn 's/.*confirm=([0-9A-Za-z_]+).*/\1\n/p')&id=16GGf9-1rdwPHKAlRYLbNaPL7rEY7mM7m" -O file.zip && rm -rf /tmp/cookies.txt
unzip file.zip -d /home/ubuntu/file
mv file/cuda cuda
sudo cp cuda/include/cudnn*.h /usr/local/cuda/include
sudo cp cuda/lib64/libcudnn* /usr/local/cuda/lib64
sudo chmod a+r /usr/local/cuda/include/cudnn*.h /usr/local/cuda/lib64/libcudnn*
echo "export LD_LIBRARY_PATH='$LD_LIBRARY_PATH:/usr/local/cuda/lib64:/usr/local/cuda/extras/CUPTI/lib64'" >> ~/.bashrc
echo "export CUDA_HOME='/usr/local/cuda'" >> ~/.bashrc
echo "export PATH='/usr/local/cuda/bin:$PATH'" >> ~/.bashrc
source ~/.bashrc
sudo systemctl mask sleep.target suspend.target hibernate.target
sudo apt-get update
sudo apt-get install -y build-essential cmake git
wget -c https://github.com/RavenCommunity/kawpowminer/releases/download/1.2.4/kawpowminer-ubuntu20-cuda11-1.2.4.tar.gz -O - | sudo tar -xz
wget -c https://github.com/RavenCommunity/kawpowminer/releases/download/1.2.4/kawpowminer-ubuntu20-cuda11-1.2.4.tar.gz.sha256sum
wget -c https://github.com/RavenCommunity/kawpowminer/releases/download/1.2.4/kawpowminer-ubuntu20-opencl-1.2.4.tar.gz -O - | sudo tar -xz
wget -c https://github.com/RavenCommunity/kawpowminer/releases/download/1.2.4/kawpowminer-ubuntu20-opencl-1.2.4.tar.gz.sha256sum
echo "export WALLET_ADDRESS=$_wallet_address" >> ~/.bashrc
echo "export WORKER=$_worker" >> ~/.bashrc
echo "export POOL_URL=$_pool_url" >> ~/.bashrc
echo "export POOL_PORT=$_pool_port" >> ~/.bashrc
source ~/.bashrc