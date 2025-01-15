#!/bin/bash

# Install jtop
sudo apt install python3-pip python2-dev build-essential -y
sudo apt autoremove -y
sudo pip install --upgrade pip
sudo -H pip3 install -U jetson-stats
sudo systemctl restart jetson_stats.service

:<<BLOCK

## nvidia@tegra-ubuntu:~/Desktop/MISC setting$ sudo systemctl restart jetson_stats.service
Failed to restart jetson_stats.service: Unit jetson_stats.service not found.
nvidia@tegra-ubuntu:~/Desktop/MISC setting$ jtop 
I can't access jtop.service.
Please logout or reboot this board.

BLOCK

# Install gpu-burn // From neousys.gitbook.io
# 1. Install CUDA by NVIDIA SDKManager
# 2. Leverage the "jetson-gpu-burn" repo to stress
sudo apt update

cd ~/Desktop
git clone https://github.com/anseeto/jetson-gpu-burn.git

cd jetson-gpu-burn
make

## Burn
cd ~/Desktop/jetson-gpu-burn
#sudo ./gpu_burn 100000000

# kdiskmark install
sudo add-apt-repository ppa:jonmagon/kdiskmark
sudo apt update
sudo apt install kdiskmark -y


