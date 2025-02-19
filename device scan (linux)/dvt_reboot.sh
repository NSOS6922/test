#!/bin/bash

COM=/dev/ttyTHS0
PW=nvidia
COUNT="10000"

DESKTOP="dvt.desktop"
LOG=`cat name.txt`

# Define colors for the menu
green='\033[38;5;82m'
red='\033[1;31m'
nc='\033[0m' # No color
BOLD="\033[1m"        # Bold text
BLINK="\033[5m"       # Blinking effect
RESET="\033[0m"       # Reset to default style

### Send I am good! #1
echo $PW | sudo -S sudo echo 'send I am good!\c
sleep 0.5
! pkill minicom
' > script.txt
echo $PW | sudo -S sudo minicom -b 9600 -D $COM -S script.txt

### Send I am good! #2
#echo $PW | sudo -S sudo chown nvidia $COM
#echo $PW | sudo -S sudo chmod o+rw $COM
#echo $PW | sudo -S sudo stty -F $COM 9600
#echo $PW | sudo -S sudo echo -ne "I am good!" >$COM


### Boot Count
COUNTER=`cat $LOG/boot_count.log`
if [ $COUNTER -lt $COUNT ]; then
     COUNTER=$((COUNTER+1))
     echo $PW | sudo -S echo $COUNTER | sudo tee $LOG/boot_count.log 1>/dev/null
     echo -e "Boot Count :\t\t$COUNTER" 

else
     echo "Finish test"
fi


### Check PCIe Devices
echo $PW | sudo -S lspci | sudo tee $LOG/PCIe.txt 1>/dev/null
echo $PW | sudo -S diff $LOG/PCIe_gloden.txt $LOG/PCIe.txt | tee diff.txt 1>/dev/null

PCIe=`cat $LOG/pcie_count.log`
if [ -s diff.txt ]; then
	PCIe=$((PCIe+1))
	echo $PW | sudo -S echo $PCIe | sudo tee $LOG/pcie_count.log 1>/dev/null
	echo -e "PCIe Check Error :\t$PCIe"
	echo $PW | sudo -S date | sudo tee -a $LOG/diff/pcie_diff.log 1>/dev/null
	echo $PW | sudo -S echo -e "Boot Count :\t\t$COUNTER" | sudo tee -a $LOG/diff/pcie_diff.log 1>/dev/null
	echo $PW | sudo -S echo -e "PCIe Check Error :\t$PCIe" | sudo tee -a $LOG/diff/pcie_diff.log 1>/dev/null
	echo $PW | sudo -S echo '--------------------------------' | sudo tee -a $LOG/diff/pcie_diff.log 1>/dev/null
	echo $PW | sudo -S diff $LOG/PCIe_gloden.txt $LOG/PCIe.txt | sudo tee -a $LOG/diff/pcie_diff.log 1>/dev/null
	echo $PW | sudo -S echo '--------------------------------' | sudo tee -a $LOG/diff/pcie_diff.log 1>/dev/null
	echo $PW | sudo -S lspci | sudo tee -a $LOG/diff/pcie_diff.log 1>/dev/null
	echo $PW | sudo -S echo '================================' | sudo tee -a $LOG/diff/pcie_diff.log 1>/dev/null
	echo $PW | sudo -S echo '' | sudo tee -a $LOG/diff/pcie_diff.log 1>/dev/null
else
	echo -e "PCIe Check Error :\t$PCIe"
fi


### Check Storage
echo $PW | sudo -S lsblk | sudo tee $LOG/Storage.txt 1>/dev/null
echo $PW | sudo -S diff $LOG/Storage_gloden.txt $LOG/Storage.txt | tee diff.txt 1>/dev/null

BLK=`cat $LOG/blk_count.log`
if [ -s diff.txt ]; then
	BLK=$((BLK+1))
	echo $PW | sudo -S echo $BLK | sudo tee $LOG/blk_count.log 1>/dev/null
	echo -e "Storage Check Error :\t$BLK"
	echo $PW | sudo -S date | sudo tee -a $LOG/diff/blk_diff.log 1>/dev/null
	echo $PW | sudo -S echo -e "Boot Count :\t\t$COUNTER" | sudo tee -a $LOG/diff/blk_diff.log 1>/dev/null
	echo $PW | sudo -S echo -e "Storage Check Error :\t$BLK" | sudo tee -a $LOG/diff/blk_diff.log 1>/dev/null
	echo $PW | sudo -S echo '--------------------------------' | sudo tee -a $LOG/diff/blk_diff.log 1>/dev/null
	echo $PW | sudo -S diff $LOG/Storage_gloden.txt $LOG/Storage.txt | sudo tee -a $LOG/diff/blk_diff.log 1>/dev/null
	echo $PW | sudo -S echo '--------------------------------' | sudo tee -a $LOG/diff/blk_diff.log 1>/dev/null
	echo $PW | sudo -S lsblk | sudo tee -a $LOG/diff/blk_diff.log 1>/dev/null
	echo $PW | sudo -S echo '================================' | sudo tee -a $LOG/diff/blk_diff.log 1>/dev/null
	echo $PW | sudo -S echo '' | sudo tee -a $LOG/diff/blk_diff.log 1>/dev/null
else
	echo -e "Storage Check Error :\t$BLK"
fi


#echo $PW | sudo -S sudo printf "\n\n\nWill reboot in 10 second\n" 

echo $PW | sudo -S sudo mv ~/.config/autostart/$DESKTOP ~/Desktop/$DESKTOP 2>/dev/null


read -t10 -n1 -s -p "Press [A] key in 10 seconds to pause." input
if [ "$input" = "" ]; then
	echo $PW | sudo -S sudo mv ~/Desktop/$DESKTOP ~/.config/autostart/$DESKTOP 2>/dev/null
else
	echo ""
	read -n1 -s -p "Press any key to continue test."
	echo $PW | sudo -S sudo mv ~/Desktop/$DESKTOP ~/.config/autostart/$DESKTOP 2>/dev/null
fi


# Set countdown duration in seconds
countdown=300  

# Log the boot attempt number and timestamp
echo "==== Cold Boot Attempt #$COUNTER ====" | sudo tee -a $LOG/time.txt 1>/dev/null
date | sudo tee -a $LOG/time.txt

# Display shutdown warning message
echo -e "${red}${BOLD}${BLINK}\n\nWill shutdown in $countdown seconds, press Ctrl + C to cancel or shut down manually.${RESET}"

# Countdown loop
while [ $countdown -gt 0 ]; do
    # Display countdown in terminal without creating new lines
    echo -ne "Counting down: $countdown seconds remaining\r"

    # Append countdown log to file
    echo "Countdown: $countdown seconds remaining" | sudo tee -a $LOG/time.txt 1>/dev/null

    sleep 1
    countdown=$((countdown - 1))
done

# Log shutdown event
    echo "Countdown finished! System shutting down..." | sudo tee -a $LOG/time.txt 1>/dev/null
sleep 3

# Execute shutdown command
echo $PW | sudo -S shutdown now
