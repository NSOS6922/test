#!/bin/bash

### JP6 CUDA
## Ref : https://neousys.gitbook.io/nru-series/misc/jetson-related/jp60_prod_porting_memo/install-jetson-sdk-on-jetson

# Install browser
sudo apt install chromium-browser-l10n -y

# Insatallation

sudo apt-get update
sudo apt-get install -y nvidia-jetpack

:<<BLOCK

## Set CUDA Path

edit ~/.bashrc

## Using CUDA 12.2 as an example
export PATH="/usr/local/cuda-12.2/bin:$PATH"
export LD_LIBRARY_PATH="/usr/local/cuda-12.2/lib64:$LD_LIBRARY_PATH"

BLOCK






