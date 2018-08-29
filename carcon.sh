#!/bin/bash

#control flag
flag="c0"
#Identify car wireless interface
int=$(ifconfig | grep wlan | cut -d' ' -f1)
#Identify car number for future reference
car=$(ifconfig | grep wlan | cut -d' ' -f1| cut -d'-' -f1 | sed 's/car//')
#Start tcpdump in each vehicle to capture data and analize after
tcpdump -i car$car\-wlan0 --direction=out -tttttnnvS --immediate-mode -l > car$car\.txt &
#Save start data time for future analis
t=$(date +%s.%N)
echo tempo_ini $t > logcar$car\.txt

while [[ true ]]; do
	#If car is connected begins transmition. Save ping output to generate RTT mean in data analisis
	if [[ $(iw dev $int link | grep SSID) != "" ]] && [[ $flag != "c1" ]]; then
		#control flag = c1 (trasmition will be initiated)
		flag="c1"
		#Save time to further analisis
		t=$(date +%s.%N)
		echo tempo_transm $t >> logcar$car\.txt

		#Start transmission to server S
		hping3 --udp -p 5002 -i u24000 -d 1470 200.0.10.2 -q &
		h1=$!
		ping 200.0.10.2 -i 1 -c 330 | while read line; do echo $(date +%s) - $line >> ping$car\_s.txt; done &
		p1=$!
		#Start transmission to server E
		hping3 --udp -p 5003 -i u24000 -d 1470 200.0.10.3 -q &
		h2=$!
		ping 200.0.10.3 -i 1 -c 330 | while read line; do echo $(date +%s) - $line >> ping$car\_e.txt; done &
        p2=$!
        #Start transmission to server E2
		hping3 --udp -p 5004 -i u12000 -d 1470 200.0.10.4 -q &
		h3=$!
		ping 200.0.10.4 -i 1 -c 330 | while read line; do echo $(date +%s) - $line >> ping$car\_e2.txt; done &
		p3=$!
		#Start transmission to server G
		hping3 --udp -p 5005 -i u24000 -d 1470 200.0.10.5 -q &
		h4=$!
		ping 200.0.10.5 -i 1 -c 330 | while read line; do echo $(date +%s) - $line >> ping$car\_g.txt; done &
		p4=$!
	#if disconnected finalize transmission
	elif [[ $(iw dev $int link | grep SSID) = "" ]] && [[ $flag = "c1" ]]; then
		#Kill process. Finalize trnasmissions
		kill -9 $h1 $p1 $h2 $p2 $h3 $p3 $h4 $p4
		#control flag = c0 (trasmition is stoped)
		flag="c0"
	fi
	sleep 0.5
done

