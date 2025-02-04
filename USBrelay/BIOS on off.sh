#!/bin/bash


read -p "Please input system boot-up time (efi shell) : " time

if [ ! -f count.log ]; then
    echo 0 > count.log
fi

for (( i=1; i<3500; i=i+1)) do

COUNT="3500"
COUNTER=`cat count.log`
if [ $COUNTER -lt $COUNT ]; then
     COUNTER=$((COUNTER+1))
     echo $COUNTER > count.log
     echo "BIOS on-off test : $COUNTER / 3500"



#echo "scale=1;b= $time / 5;print  b" |bc;echo
#echo "scale=1;c= $time / 4;print  c" |bc;echo
#echo "scale=1;d= $time / 3;print  d" |bc;echo
#echo "scale=1;e= $time / 2;print  e" |bc;echo
#echo "scale=1;f= $time / 1;print  f" |bc;echo

a=$(echo "scale=1;$time / 6" | bc)
b=$(echo "scale=1;$time / 3" | bc)
c=$(echo "scale=1;$time / 2" | bc)
d=$(echo "scale=1;$time / 1.5" | bc)
e=$(echo "scale=1;$time / 1.2" | bc)
f=$(echo "scale=1;$time / 1" | bc)

./on.sh /dev/ttyUSB0 
sleep $a
./off.sh /dev/ttyUSB0
sleep 5

./on.sh /dev/ttyUSB0 
sleep $b
./off.sh /dev/ttyUSB0
sleep 5

./on.sh /dev/ttyUSB0 
sleep $c
./off.sh /dev/ttyUSB0
sleep 5

./on.sh /dev/ttyUSB0 
sleep $d
./off.sh /dev/ttyUSB0
sleep 5

./on.sh /dev/ttyUSB0 
sleep $e
./off.sh /dev/ttyUSB0
sleep 5

./on.sh /dev/ttyUSB0 
sleep $f
./off.sh /dev/ttyUSB0
sleep 5

else
     echo "Finish test"
fi

done
