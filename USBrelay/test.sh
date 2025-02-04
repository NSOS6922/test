
if [ -n "$1" ] && [ -n "$2" ] && [ -n "$3" ] && [ -n "$4" ] && [ -n "$5" ]
#$1 -> at/atx
#$2 -> USB*
#$3 -> COM*
#$4 -> ON
#$5 -> OFF

then
	clear
	printf "$1 $2 $3 $4 $5 \n"
	count=0
	pass=0
	fail=0
	delay=15
	LOG_FILE="Log_$(date +%y%m%d-%H%M%S).txt"
	
	printf "Start time: $(date -R) \n" > $LOG_FILE
	echo $(<$LOG_FILE)
	
	if [ "$1" = "at" ]
	then
		./off.sh /dev/$2
		sleep 1
		
		printf "Tested: $count \n"
		printf "Passed: $pass \n"
		printf "Failed: $fail \n"
		
		while true
		do		
			./on.sh /dev/$2
			
			./listen.sh $3 &
			sleep $4
			
			txt=$(cat $3.log)
			
			if [ "$txt" = "Iamgood!" ]
			then
				pkill -f "listen.sh $3"
				./off.sh /dev/$2
				#printf "OK"
				pass=$((pass+1))
			else
				sleep $delay
				pkill -f "listen.sh $3"
				./off.sh /dev/$2
				#printf "NO"
				txt=$(cat $3.log)
				if [ "$txt" = "Iamgood!" ]
				then
					pass=$((pass+1))
				else
					fail=$((fail+1))
					printf "Failed $fail at $(date -R) \t" >> $LOG_FILE
					printf "$(<$3.log) \n" >> $LOG_FILE
					
				fi
			fi
			
			count=$((count+1))
			
			printf "\033[3A"
			printf "Tested: $count \n"
			printf "Passed: $pass \n"
			printf "Failed: $fail \n"
#			printf "\033[3A"
	
			sleep $5
			
		done
	elif [ "$1" = "atx" ]
	then
	
		printf "Tested: $count \n"
		printf "Passed: $pass \n"
		printf "Failed: $fail \n"
		
		while true
		do
			./on.sh /dev/$2
			sleep 0.5
			./off.sh /dev/$2
			
			./listen.sh $3 &
			sleep $4
			
			txt=$(cat $3.log)
			
			if [ "$txt" = "Iamgood!" ]
			then
				pkill -f "listen.sh $3"
				./on.sh /dev/$2
				sleep 0.5
				./off.sh /dev/$2
				#printf "OK"
				pass=$((pass+1))
			else
				sleep $delay
				pkill -f "listen.sh $3"
				./on.sh /dev/$2
				sleep 0.5
				./off.sh /dev/$2
				#printf "NO"
				txt=$(cat $3.log)
				if [ "$txt" = "Iamgood!" ]
				then
					pass=$((pass+1))
				else
					fail=$((fail+1))
					printf "Failed $fail at $(date -R) \t" >> $LOG_FILE
					printf "$(<$3.log) \n" >> $LOG_FILE
					
				fi
			fi
			
			count=$((count+1))
			
			printf "\033[3A"
			printf "Tested: $count \n"
			printf "Passed: $pass \n"
			printf "Failed: $fail \n"
#			printf "\033[3A"
	
			sleep $5
			
		done
	fi
else
	printf "Usage: ./test.sh [at/atx] [ttyUSB*] [ttyS*] [ON time] [OFF time] \n"
fi

#on
#echo -e -n "\xa0\x01\x01\xa2" > /dev/ttyUSB0

#off
#echo -e -n "\xA0\x01\x00\xa1" > /dev/ttyUSB0

