#!/bin/bash

COM=/dev/$1
READ_LOG=$1.log

sudo stty -F $COM 9600

sudo rm $READ_LOG 2>/dev/null
>$READ_LOG

while read -rs -n 1 c
do
	printf "$c" >> $READ_LOG
done < $COM
bash
