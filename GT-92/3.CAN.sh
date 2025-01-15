#!/bin/bash 


:<<BLOCK
modprobe can
modprobe can-raw
modprobe mttcan
sudo ip link set can0 down
sudo ip link set can0 up type can bitrate 1000000 

sudo ip link set can1 down
sudo ip link set can1 up type can bitrate 1000000
sudo ifconfig can1 txqueuqlen 1000

gnome-terminal -e "candump can0 -L"
gnome-terminal -e "cangen can1 -i -v"


#sudo cangen can0 -i

BLOCK

cd /home/gt92gc/Desktop/can_can/fintek
sudo ./CANBUS_config.sh

gnome-terminal -- candump can1 -L
gnome-terminal -- cangen can0 -i -v
