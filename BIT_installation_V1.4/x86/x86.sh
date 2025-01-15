#!/bin/bash

# Define ANSI escape codes for green color bold and blinking text
GREEN="\033[32m"      # Green color
RED="\033[31m"        # Red color
BOLD="\033[1m"        # Bold text
BLINK="\033[5m"       # Blinking effect
RESET="\033[0m"       # Reset to default style


# Print blinking and green text
echo -e "${GREEN}${BOLD}${BLINK}Please enter your root password${RESET}"


# Wait for the user to input their password
read -s -p "Password: " password
echo
echo -e "The password you entered is: ${RED}${BOLD}${BLINK}${password}${RESET}"

sleep 5



# find file "BurnInTest_Linux_x86-64.tar.gz" full path and enter into the directory.
cd "$(dirname "$(sudo find / -name 'BurnInTest_Linux_x86-64.tar.gz' 2>/dev/null | head -n 1)")"
echo $password | sudo -S sudo  tar -zxvf BurnInTest_Linux_x86-64.tar.gz
echo $password | sudo -S sudo chmod 777 * burnintest
sudo cp -r key.dat burnintest/   #sudo cp -r cmdline_config.txt $HOME/Desktop/BIT_installation_V1.4/x86/burnintest



# Installing required libraries
sudo apt update
#sudo rm /var/cache/apt/archives/lock
#sudo rm /var/lib/dpkg/lock
sudo apt install -y libqt5opengl5 libqt5webkit5 libqt5multimedia5 libqt5printsupport5 libqt5script5 libqt5scripttools5 libcurl4 php-curl libQt5WebKit* libncurses5



# BIT execution
cd "$(dirname "$(sudo find / -name 'bit_gui_x64' 2>/dev/null | head -n 1)")"   #cd $HOME/Desktop/BIT_installation_V1.4/x86/burnintest
echo $password | sudo -S sudo chmod 777 *
echo $password | sudo -S sudo ./bit_cmd_line_x64 -k
echo -e "${GREEN}${BOLD}${BLINK}To check license key is avaliable , you'll see Registration successful${RESET}"
echo $password | sudo -S sudo ./bit_gui_x64


