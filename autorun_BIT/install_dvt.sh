#!/bin/bash

### Check root permission
if [ "$EUID" -ne 0 ]; then
    echo "Please run with sudo"
    exit
fi


SCRIPT_WIN="dvt_win.sh"
SCRIPT="BIT.sh"
DESKTOP="dvt.desktop"
mkdir -p /home/${SUDO_USER}/.config/autostart/
cp $DESKTOP /home/${SUDO_USER}/.config/autostart/
sudo cp $SCRIPT /usr/src/
sudo cp $SCRIPT_WIN /usr/src/
sudo cp shutdown.sh /usr/src/

echo "DVT BIT Installed (expected username/password = nvidia/nvidia)"
echo "> BIT script: /usr/src/$SCRIPT"
#echo "> will send 'I am good!' (no newline) to /dev/ttyTHS1 with baudrate 9600 after reboot"

