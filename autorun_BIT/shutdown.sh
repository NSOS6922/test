#!/bin/bash

PW=0000


echo $PW | sudo -S sudo printf "\n\n\nWill reboot in 930 second\n" 
sleep 930

echo $PW | sudo -S sudo reboot
#echo $PW | sudo -S sudo shutdown now

