#!/bin/bash

##Set and apply queues on switches
echo -e "\n Configuring queues"

#erase the file for local information storage
rm -f temp2.txt

#collects the DPIDs of the switches in the regions of interest with their interfaces to apply queues and saves in temp2.txt
mysql -u root -pwifi -e "select dpid,iface_updtip from rsu where Region IN (select region from appkpi)" framework 2> /dev/null | grep '-' |
while read i;
do
	echo $i >> temp2.txt
done

#clear the ontrol variable
t2=0

#Identify DPIDs
b2=$(cat temp2.txt | awk -F' ' '{print $1}')


#For each DPID
for i in $b2;
do
	#inc control variable
	t2=$(echo $t2+1 | bc)

	#saves the values of DPID in x2 and in y2 the values of inteferface, to mount the expressions REST
	x2=$(cat temp2.txt | awk -F' ' '{print $1}' | cut -d$'\n' -f$t2)
	y2=$(cat temp2.txt | awk -F' ' '{print $2}' | cut -d$'\n' -f$t2)

	#salva em x os valores de data_rate de cada aplicação para aplicar o QoS
	# x=$(mysql -u root -pwifi -e "select appkpi.data_rate, infrastructure.ip from appkpi inner join infrastructure on appkpi.id = infrastructure.app;" framework 2> /dev/null | grep '\.' |
	# while read i;
	# do
	# 	echo $i | awk -F' ' '{print $1}'
	# done)

	x=$(mysql -u root -pwifi -e "select data_rate from appkpi;" framework 2> /dev/null | grep 0 |
	while read i;
	do
		echo $i
		# echo $i*1.1 | bc
	done)

	#x=$(mysql -u root -pwifi -e "select data_rate from appkpi;" framework 2> /dev/null | grep 0 | while read i;	do echo $i;	done)

	#Number of queues = number of applications (counter)
	c=$(echo $x | wc -w)

	# sets the minimum rates to apply for each queue. Ex {"min_rate": "500000"}
	h=$(for i in $x; do echo {\"min_rate\": "\"$(echo $i)\""},; done | paste -s | cut -d',' -f1-$c)

	#define final command with fixed max_rate (improve / adjust)
	j=$(echo curl -X POST -d "'{\"port_name\": \"$y2\", \"type\": \"linux-htb\", \"max_rate\": \"5000000\", \"queues\": [{\"max_rate\": \"5000000\"}, $(echo $h)]}'" http://localhost:8080/qos/queue/000000000000000$x2)
	
	#Send command to the controller, containing the queues and references of DPID (switch) and port
	# echo $j
	/bin/sh -c "$j"

done

echo -e "\n Configuring QoS"

# clear the control variable
t2=0

#For each DPID
for i in $b2;
do
	#inc the control variable
	t2=$(echo $t2+1 | bc)

	#saves emn x2 the values of DPID
	x2=$(cat temp2.txt | awk -F' ' '{print $1}' | cut -d$'\n' -f$t2)

	#Clear the file for storing local information
	rm -f temp.txt

	#search the IP address and port information of the servers where the applications are located, and save locally in temp.txt
	mysql -u root -pwifi -e "select infrastructure.ip, appkpi.port from appkpi inner join infrastructure on appkpi.id = infrastructure.app;" framework 2> /dev/null | grep '\.' |
	while read i;
	do
		echo $i >> temp.txt
	done

	#internal control variable
	t=0

	# Stores the values of IP addresses in b
	b=$(cat temp.txt | awk -F' ' '{print $1}')


	#For each application server IP address
	for i in $b;
	do
		#inc control variable
		t=$(echo $t+1 | bc)

		#Stores the IP address at x and port on y
		x=$(cat temp.txt | awk -F' ' '{print $1}' | cut -d$'\n' -f$t)
		y=$(cat temp.txt | awk -F' ' '{print $2}' | cut -d$'\n' -f$t)

		#Assembles and sends the command associating the traffic referring to the IP of the server and the port, its queue and in all the DPIDs
		#echo curl -X POST -d '{"match": {"nw_dst": "'$x'", "nw_proto": "UDP", "tp_dst": "'$y'"}, "actions":{"queue": "'$t'"}}' http://localhost:8080/qos/rules/000000000000000$x2
		curl -X POST -d '{"match": {"nw_dst": "'$x'", "nw_proto": "UDP", "tp_dst": "'$y'"}, "actions":{"queue": "'$t'"}}' http://localhost:8080/qos/rules/000000000000000$x2
		curl -X POST -d '{"match": {"nw_dst": "'$x'", "nw_proto": "ICMP"}, "actions":{"queue": "'$t'"}}' http://localhost:8080/qos/rules/000000000000000$x2
	done
done


echo -e "\n Finishing"
