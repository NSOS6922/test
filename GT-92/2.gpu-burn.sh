#!/bin/bash

gnome-terminal --geometry=100x24 -- watch -n 1 nvidia-smi

cd /home/gt92gc/Desktop/gpu-burn
sudo ./gpu_burn 10000000
