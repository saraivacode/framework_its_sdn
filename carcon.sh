#!/bin/bash

flag="c0"

int=$(ifconfig | grep wlan | cut -d' ' -f1)

car=$(ifconfig | grep wlan | cut -d' ' -f1| cut -d'-' -f1 | sed 's/car//')

#echo car$car $(iw dev $int link) >> logcar.txt

tcpdump -i car$car\-wlan0 --direction=out -tttttnnvS --immediate-mode -l > car$car\.txt &

t=$(date +%s.%N)
echo tempo_ini $t > logcar$car\.txt

while [[ true ]]; do
	#statements
	#se estiver conectado
	if [[ $(iw dev $int link | grep SSID) != "" ]] && [[ $flag != "c1" ]]; then

		flag="c1"
		t=$(date +%s.%N)
		echo tempo_transm $t >> logcar$car\.txt

		hping3 --udp -p 5002 -i u24000 -d 1470 200.0.10.2 -q &
		h1=$!
		ping 200.0.10.2 -i 1 -c 330 | while read line; do echo $(date +%s) - $line >> ping$car\_s.txt; done &
		p1=$!

		hping3 --udp -p 5003 -i u24000 -d 1470 200.0.10.3 -q &
		h2=$!
		ping 200.0.10.3 -i 1 -c 330 | while read line; do echo $(date +%s) - $line >> ping$car\_e.txt; done &
        p2=$!

		hping3 --udp -p 5004 -i u12000 -d 1470 200.0.10.4 -q &
		h3=$!
		ping 200.0.10.4 -i 1 -c 330 | while read line; do echo $(date +%s) - $line >> ping$car\_e2.txt; done &
		p3=$!

		hping3 --udp -p 5005 -i u24000 -d 1470 200.0.10.5 -q &
		h4=$!
		ping 200.0.10.5 -i 1 -c 330 | while read line; do echo $(date +%s) - $line >> ping$car\_g.txt; done &
		p4=$!
	elif [[ $(iw dev $int link | grep SSID) = "" ]] && [[ $flag = "c1" ]]; then

		kill -9 $h1 $p1 $h2 $p2 $h3 $p3 $h4 $p4
		flag="c0"
	fi
	sleep 0.5
done

