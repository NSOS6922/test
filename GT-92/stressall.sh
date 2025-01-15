#!/bin/bash

if [ "$EUID" -ne 0 ]
   then echo "Please run with sudo"
   exit
fi

Path=/home/gt92gc/Desktop/GT-92

# 

gnome-terminal -- $Path/1.CPU-MEM--COM-BIT.sh
gnome-terminal -- $Path/2.gpu-burn.sh
gnome-terminal -- $Path/3.CAN.sh
gnome-terminal -- $Path/4.DIO.sh
cd /home/gt92gc/Desktop/GT-92
sudo -u gt92gc gnome-terminal -- bash 5.audio.sh
