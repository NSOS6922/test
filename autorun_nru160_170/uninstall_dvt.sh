#!/bin/bash

### Check root permission
if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo"
    exit
fi

SCRIPT_WIN="dvt_win.sh"
SCRIPT="stressall.sh"
DESKTOP="dvt.desktop"

sudo rm /home/${SUDO_USER}/.config/autostart/$DESKTOP 2>/dev/null
sudo rm /usr/src/$SCRIPT 2>/dev/null
sudo rm /usr/src/$SCRIPT_WIN 2>/dev/null

echo "stressall Uninstalled"



