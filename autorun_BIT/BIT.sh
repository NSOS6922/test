#!/bin/bash

:<<BLOCK
if [ "$EUID" -ne 0 ]
   then echo "Please run with sudo"
   exit
fi

Path=$HOME/Desktop/BIT_installation_V1.3/x86/burnintest
PW=0000

BLOCK

# stress
cd /home/dvt/Desktop/BIT_installation_V1.3/x86/burnintest
echo 0000 | sudo -S sudo ./bit_gui_x64 -R

