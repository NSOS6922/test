#!/bin/bash

### Check root permission
if [ "$EUID" -ne 0 ]; then
    echo "Be the superuser and try again"
    exit
fi


# Install USB driver for the USB relay.

sudo apt update
sudo apt install git -y
git clone https://github.com/juliagoda/CH341SER
cd CH341SER

# Make and load driver:

sudo apt install build-essential gcc-12 -y

sudo make clean;make

sudo make load



read -p "Press enter to continue. (Remove brltty)" var



# Remove brltty:

sudo apt -y autoremove brltty



read -p "Press enter to continue. (Check USB)" var



# Check that USB port is ready: please insert your USB device

sudo dmesg |grep -i ch341

#echo "This would show which USB port CH341"

echo "Plese reboot your system before using USB-relay."


# sudo chmod 777 listen.sh  off.sh on.sh test.sh  // To change permission of files

# Usage: ./test.sh [at/atx] [ttyUSB*] [ttyS*] [ON time] [OFF time]
# e.g.  ./test.sh at ttyUSB0 ttyS0 30 30

# To set a relay as “open”:
# ./off.sh /dev/ttyUSB*

# To set a relay as “closed”:
# ./on.sh /dev/ttyUSB*
