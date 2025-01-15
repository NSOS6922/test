#!/bin/bash

### Check root permission
if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo"
    exit
fi


SCRIPT_WIN="dvt_win.sh"
SCRIPT="stressall.sh"
DESKTOP="dvt.desktop"
mkdir -p /home/${SUDO_USER}/.config/autostart/
cp $DESKTOP /home/${SUDO_USER}/.config/autostart/
sudo cp $SCRIPT /usr/src/
sudo cp $SCRIPT_WIN /usr/src/

echo "DVT stressall Installed (expected username/password = nvidia/nvidia)"
echo "> stressall script: /usr/src/$SCRIPT"
#echo "> will send 'I am good!' (no newline) to /dev/ttyTHS1 with baudrate 9600 after reboot"

