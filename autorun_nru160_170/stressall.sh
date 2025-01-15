#!/bin/bash

if [ "$EUID" -ne 0 ]
   then echo "Please run with sudo"
   exit
fi

Path=/home/nvidia/Desktop/Stress_NRU160_170V
PW=nvidia

# Set iperf3 receive setting
echo $PW | sudo -S sudo gnome-terminal -- $Path/1.CPU-MEM--COM-BIT.sh
echo $PW | sudo -S sudo gnome-terminal -- $Path/2.gpu-burn.sh
#echo $PW | sudo -S sudo gnome-terminal -- $Path/3.LAN1.sh
echo $PW | sudo -S sudo gnome-terminal -- $Path/6.Camera.sh
echo $PW | sudo -S sudo gnome-terminal -- $Path/4.pps.sh
echo $PW | sudo -S sudo gnome-terminal -- $Path/5.CANtoUSB.sh
echo $PW | sudo -S sudo gnome-terminal -- sudo jtop
