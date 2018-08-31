#!/bin/bash

#define static link capabilitie
up=5000000
#Define the periodic time that local controllers check local RAN status
t=5
#Define the periodic time that local controllers wait to confirm an congestion
t2=20
#Get from database the  appb and appc bw requirements
appb_bw=500000
appc_bw=1000000

SECONDS=0

#Function that calculate the balance of each RAN
function calc {
	#If there is somo vehicle in RAN
	if [[ $(echo $x | wc -w) -gt 0 ]]; then
		#calc demands based os MACs in each RAN
		y=$(
		for i in $x;
		do
			mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"')" framework 2> /dev/null |tail -1
		done | paste -s | expand | tr -s ' ' | sed 's/ /+/g' |sed 's/NULL/0/g'| bc)	
		#calc App class B requirements
		b=$(
		for i in $x;
		do
			mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"B"'" framework 2> /dev/null |tail -1
		done | paste -s | expand | tr -s ' ' | sed 's/ /+/g' |sed 's/NULL/0/g'| bc)
		#calc App class C requirements
		c=$(
		for i in $x;
		do
			mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"C"'" framework 2> /dev/null |tail -1
		done | paste -s | expand | tr -s ' ' | sed 's/ /+/g' |sed 's/NULL/0/g'| bc)
	else
		y=0
		b=0
		c=0
	fi	
	#Verify if there are flows registered in database that RSU in analisis is the destination (to debit from balance)
	dec=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where rsu_dest= '"$rsu_calc"' " framework 2> /dev/null | tail -1)
	##Verify if there are flows registered in database that RSU in analisis is the source (to increment in balance)
	inc=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where rsu_o= '"$rsu_calc"' " framework 2> /dev/null | tail -1)
	#When the result of previous functions is NULL, change to 0, proceed with calc
	if [ $inc = "NULL" ]; then
		inc=0
	fi
	if [ $dec = "NULL" ]; then
		dec=0
	fi					
	#Calc the balance of RSU in analisis
	sd=$(echo $up-$y-$dec+$inc|bc)

	#Update control files with updated balance information
	cat saldo.txt | grep -v $rsu_calc > temp.tmp
	echo $rsu_calc $sd >> temp.tmp
	rm saldo.txt
	mv temp.tmp saldo.txt
}

#Function to clean flows and database informations related to vehicles that is not more in RSU RAN
function limpeza {
	#Identify MACs in redirection that local RSU in source
	mac_rec=$(mysql -u root -pwifi -e "select mac from redirect where rsu_o= '"$rsu"' " framework 2> /dev/null | grep -v mac)
	#Verify if these MACs are still in RAN and, if not, erase them from tables (with related configurations  - eg. flows)
	#MAC named internet ias an excption that refers that generic "internet" data was blocked in that RAN
	for m in $mac_rec;
	do
		#if [[ $(hostapd_cli -i $j all_sta | grep $m -c) -eq 0 ]] && [[ $m != "internet" ]]; then
		if [[ $(echo $x | grep $m -c) -eq 0 ]] && [[ $m != "internet" ]]; then
			#verify destination RSUs of redirections
			dst=$(mysql -u root -pwifi -e "select rsu_dest from redirect where mac  = \"$m\" and rsu_o = \"$rsu\"" framework 2> /dev/null | tail -1)
			echo -e "\n Erasing invalid MAC... " $m" em " $rsu
			mysql -u root -pwifi -e "delete from redirect where mac  = \"$m\" and rsu_o = \"$rsu\"" framework 2> /dev/null
			#Erase flows in source RSU
			ovs-ofctl del-flows $rsu cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$m -O Openflow13
			ovs-ofctl del-flows $rsu cookie=0x$(echo $rsu | cut -d'u' -f2)5/-1,dl_src=$m -O Openflow13
			#Erase flows in backbone
			ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$m -O Openflow13
			ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$m -O Openflow13
			#If the data was not blocked (limited), erase flows in destination RSU
			if [[ $dst != "x" ]]; then
				ovs-ofctl del-flows $dst cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$m -O Openflow13
				ovs-ofctl del-flows $dst cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$m -O Openflow13
			fi
		fi
	done
}

#Begin of local control program
while true;
do
	#initialize files that will be used to reference of balance
	rm -f saldo.txt
	touch saldo.txt
	#For each wlan interface of each RSU in evaluation enviroment
	for j in $(ifconfig | grep wlan | cut -d' ' -f1);
	do
		#identify rsu
		rsu=$(echo $j | cut -d'-' -f1)
		#Identify MACs of vehicles in rsu
		#x=$(hostapd_cli -i $j all_sta | grep :)
		x=$(iw dev $j station dump | grep wlan | cut -d' ' -f2)
		#Procede with cleaning of old MACs
		limpeza
		#initialize values to balance calc
		sd=$up
		y=0
		b=0
		c=0
		inc=0
		dec=0
		#IUpdate initial state balance files
		cat saldo.txt | grep -v $rsu > temp.tmp
		echo $rsu $up >> temp.tmp
		rm saldo.txt
		mv temp.tmp saldo.txt
		#Verify if exists redirection register related to RAN in analisis (So calc balance even if there is no vehicles in RAN)
		r=$(mysql -u root -pwifi -e "select * from redirect" framework 2> /dev/null | grep -c $rsu)
		if [ $r = "NULL" ]; then
			r=0
		fi
		rsu_calc=$rsu
		#If tehre is vehicles in RAN or redirecion register, calc balance
		if [[ $(echo $x | wc -w) -gt 0 ]] || [[ $r -gt 0 ]]; then
			calc			
		fi
		#Print results of balance (control debug messages)
		#echo -e $(date) $rsu " has a demand of " $(echo $y|bc)   " ($b B and $c C)." " dec: " $dec " inc: " $inc " bl: " $sd ". " $(echo $x| wc -w) "cars. r " $r
		echo -e $(echo $SECONDS-15|bc) - $rsu " has a demand of " $(echo $y|bc)   " ($b B and $c C)." " dec: " $dec " inc: " $inc " bl: " $sd ". " $(echo $x| wc -w) "cars. r " $r
	done
	echo -e "\n =========================================//==============================================================="
	##################################Part 2 of program, that deal with redirections#####################################
	#For each rsu in balance file (eg. rsu1, rsu2 and rsu3)
	for rsu in $(cat saldo.txt | cut -d' ' -f1);
	do
		#If rsu has a balance less than zero, wait a time and calc again the balance of rsu and its neighbors, to confirm
		if [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; then
			echo $rsu "congested. Waiting "$t2" seconds to confirm..."
			sleep $t2
			echo "recalculating balance of RSUs..."
			for j in $(ifconfig | grep wlan | cut -d' ' -f1);
			do
				rsu_calc=$(echo $j | cut -d'-' -f1)
				#x=$(hostapd_cli -i $j all_sta | grep :)
				x=$(iw dev $j station dump | grep wlan | cut -d' ' -f2)
				calc
				#echo -e $(date) $rsu_calc " has a demand of " $(echo $y|bc)   " ($b B and $c C)." " dec: " $dec " inc: " $inc " bl: " $sd ". " $(echo $x| wc -w) "cars. r " $r
				echo -e $(echo $SECONDS-15|bc) - $rsu " has a demand of " $(echo $y|bc)   " ($b B and $c C)." " dec: " $dec " inc: " $inc " bl: " $sd ". " $(echo $x| wc -w) "cars. r " $r
			done
			echo -e "\n =========================================//==============================================================="
		fi

		#If balance still is negative and in case of these evaluation is rsu1 or rsu3, that has only one neighbor (rsu2)
		if [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]] && [[ $rsu != "rsu2" ]]; then
			#While balance in rsu (1 or 3) is negative
			while [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; do
				#identify MACs in RSU
				#mac_rsu1=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
				mac_rsu1=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2)

				#initialize control files of App B and C applications
				rm -f appc.txt
				rm -f appb.txt

				#For each MAC in rsu, verify if related vehicle are assigned with application B and C and saves these information in file,
				#if the traffic app was not redirected or blocked/limited yet
				for i in $mac_rsu1;
				do
					res_c=$(mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"C"'" framework 2> /dev/null |tail -1)
					res_b=$(mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"B"'" framework 2> /dev/null |tail -1)
					red_c=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where mac='"$i"' and rsu_o='"$rsu"' and bw_value=$appc_bw" 2> /dev/null framework | tail -1)
					red_b=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where mac='"$i"' and rsu_o='"$rsu"' and bw_value=$appb_bw" 2> /dev/null framework | tail -1)
					if [ $res_b != "NULL" ] && [ $red_b = "NULL" ]; then
						echo $i >> appb.txt
					fi
					if [ $res_c != "NULL" ] && [ $red_c = "NULL" ];
						then echo $i >> appc.txt;
					fi
				 done
				# If neighboor (rsu2) can deal with at least one C application and there is vehicle with C application in congested RAN
				if [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $appc_bw ]] && [[ $(cat appc.txt | wc -l) -gt 0 ]]; then
					#For each MAC associataed with C application
					for i in $(cat appc.txt);
					do
						#While there is balance in neighbor to deal with C application and local RAN is congested
						if [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $appc_bw ]] && [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]] ; then
							#Print control messages
							echo -e "\n $rsu congested. RSU2 suportts at least an C application. C applications will be redirected until balance over app C demand."
							echo $i " is associated to an C application"
							echo "redirecting " $i " from $rsu to rsu2"
							#Install local flows (with high priority) to traffic redirection to neighbor (rsu2)
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=2" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.4, icmp actions=2" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=2, dl_dst=$i, icmp actions=1" -O Openflow13
							
							#Install flows in redirection RSU (if source is rsu1 or rsu3, the flows will be different, because of ports connected)
							if [[ $rsu = "rsu1" ]]; then
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=4" -O Openflow13
								# ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4,dl_dst=$i, udp,tp_src=5004 actions=2" -O Openflow13
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2,dl_src=$i, nw_dst=200.0.10.4, icmp actions=4" -O Openflow13
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4,dl_dst=$i, icmp actions=2" -O Openflow13
							else
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=3,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=4" -O Openflow13
								# ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4,dl_dst=$i, udp,tp_src=5004 actions=3" -O Openflow13
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=3,dl_src=$i, nw_dst=200.0.10.4, icmp actions=4" -O Openflow13
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4,dl_dst=$i, icmp actions=3" -O Openflow13

							fi
							#Install flows with high priority in backbone
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1,dl_dst=$i, udp,tp_src=5004 actions=3" -O Openflow13
							
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3,dl_src=$i, nw_dst=200.0.10.4, icmp actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1,dl_dst=$i, icmp actions=3" -O Openflow13

							#Delete flows in backbone - enable only in automatic moving of vehicles (with mobility script)
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
							#cadastra na banco
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"rsu2\", $appc_bw)" framework 2> /dev/null
							#Calc to update balance in source and destination RSUs
							rsu_calc=rsu2
							#x=$(hostapd_cli -i rsu2-wlan1 all_sta | grep :)
							x=$(iw dev rsu2-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc 
							rsu_calc=$rsu
							#x=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
							x=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc
						fi
					done
				elif [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $appb_bw ]] && [[ $(cat appb.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appb.txt);
					do
						#If RSU is congested and neighbor dont can deal with C application verify if its possible with B
						if [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $appb_bw ]] && [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; then
							#Control messages
							echo -e "\n $rsu still congested. RSU2 can deal with at least one application B. Applications B will be redirected while neighbor can deal with it"
							echo $i " its associated to an B application"
							echo "redirecting " $i " from $rsu to rsu2"
							#Redirect App B data to neighbor (rsu2) - install flows in source rsu
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.3, udp,tp_dst=5003 actions=2" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.3, icmp actions=2" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=2, dl_dst=$i, icmp actions=1" -O Openflow13
							#Install flows in redirection RSU (if source is rsu1 or rsu3, the flows will be different, because of ports connected)
							if [[ $rsu = "rsu1" ]]; then
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=2, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=4" -O Openflow13
								# ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4, dl_dst=$i, udp,tp_src=5003 actions=2" -O Openflow13
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=2, dl_src=$i, nw_dst=200.0.10.3, icmp actions=4" -O Openflow13
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4, dl_dst=$i, icmp actions=2" -O Openflow13
							else
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=4" -O Openflow13
								# ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4, dl_dst=$i, udp, tp_src=5003 actions=3" -O Openflow13
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_src=$i, nw_dst=200.0.10.3, icmp actions=4" -O Openflow13
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4, dl_dst=$i, icmp actions=3" -O Openflow13
							fi
							#Install flows with high priority in backbone
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_dst=$i, udp, tp_src=5003 actions=3" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_src=$i, nw_dst=200.0.10.3, icmp actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_dst=$i, icmp actions=3" -O Openflow13
							#Delete flows in backbone - enable only in automatic moving of vehicles (with mobility script)
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
							#register information in database
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"rsu2\", $appb_bw)" framework 2> /dev/null
							#Calc to update balance in source and destination RSUs
							rsu_calc=rsu2
							x=$(iw dev rsu2-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc 
							rsu_calc=$rsu
							x=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc
						fi
					done
				#if rsu is still congested and neighbor has no balance to deal with B or C applications
				elif [[ $(cat appc.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appc.txt);
					do				
						if [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; then
							echo -e "\n $rsu is still congested. RSU2 there is no balance available. C applications will be limited, and internet (app G) blocked in RAN."
							echo $i " is associeted to C application and will be limited"
							echo "limiting " $i " em $rsu..."				
							#Limit app C to default less priority queue, block app G in RAN and register this in database
							ovs-ofctl add-flow $rsu "table=0, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.4, udp, tp_dst=5004 actions=set_queue:0,goto_table:1" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)8, in_port=1, nw_dst=200.0.10.5, udp,tp_dst=5005 actions=drop" -O Openflow13

							ovs-ofctl add-flow $rsu "table=0, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.4, icmp actions=set_queue:0,goto_table:1" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)8, in_port=1, nw_dst=200.0.10.5, icmp actions=drop" -O Openflow13

							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"x\", $appc_bw)" framework 2> /dev/null				
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"internet\", \"$rsu\", \"x\", 0)" framework 2> /dev/null
							#recalc balance
							rsu_calc=$rsu
							x=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc 
						fi
					done
				#Verify the possibilitie of limit App C redirected to neighbors, before change App B
				elif [[ $(mysql -u root -pwifi -e "select mac from redirect where rsu_o='"$rsu"' and bw_value=$appc_bw and rsu_dest!='"x"'" framework 2> /dev/null | grep -v mac | tail -1 | grep : -c ) -gt 0 ]]; then
					echo -e "\n $rsu still congested. RSU2 dont has available balance. C applications redirected will be locally limited until there is balance in neighbor."
					#identify C applications previously redirected
					i=$(mysql -u root -pwifi -e "select mac from redirect where rsu_o='"$rsu"' and bw_value=$appc_bw" framework 2> /dev/null | grep -v mac | tail -1)
					echo "C application in $i was redirected and will be locally limited. Internet also will be blocked"
					#Limit C application in local RAN and block internet also. Delete flows related to previous redrection and update db register
					ovs-ofctl add-flow $rsu "table=0, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.4, udp, tp_dst=5004 actions=set_queue:0,goto_table:1" -O Openflow13
					ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)8, in_port=1, nw_dst=200.0.10.5, udp,tp_dst=5005 actions=drop" -O Openflow13

					ovs-ofctl add-flow $rsu "table=0, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.4, icmp actions=set_queue:0,goto_table:1" -O Openflow13
					ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)8, in_port=1, nw_dst=200.0.10.5, icmp actions=drop" -O Openflow13

					ovs-ofctl del-flows $rsu cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,udp,tp_dst=5004 -O Openflow13
					# ovs-ofctl del-flows rsu2 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$i,udp,tp_src=5004 -O Openflow13
					ovs-ofctl del-flows $rsu cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,icmp -O Openflow13
					ovs-ofctl del-flows $rsu cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$i,icmp -O Openflow13

					ovs-ofctl del-flows rsu2 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,udp,tp_dst=5004 -O Openflow13
					# ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$i,udp,tp_src=5004 -O Openflow13
					ovs-ofctl del-flows rsu2 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,icmp -O Openflow13
					ovs-ofctl del-flows rsu2 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$i,icmp -O Openflow13

					ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,udp,tp_dst=5004 -O Openflow13
					ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,icmp -O Openflow13
					ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$i,icmp -O Openflow13

					mysql -u root -pwifi -e "update redirect set rsu_dest=\"x\" where mac=\"$i\" and bw_value=$appc_bw" framework 2> /dev/null
					mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"internet\", \"$rsu\", \"x\", 0)" framework 2> /dev/null
					#recalc balance in neighbor
					rsu_calc=rsu2
					x=$(iw dev rsu2-wlan1 station dump | grep wlan | cut -d' ' -f2)
					calc 
				#last case, limit app B and block app C that was limited
				elif [[ $(cat appb.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appb.txt);
					do
						if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -lt 0 ]]; then
							echo -e "\n $rsu is still congested. RSU2 dont has availabel balance. No actions to do in C applications. B applications will be limited until there is positive balance, and C of this vehicle blocked."
							echo $i " is associated to an B application and will be limited, and C blocked"
							echo "blocking " $i " in $rsu..."
							#Install flow to limit application B in RAN and block C Application of vehicle and register in database
							ovs-ofctl add-flow $rsu "table=0, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=set_queue:0,goto_table:1" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=drop" -O Openflow13

							ovs-ofctl add-flow $rsu "table=0, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.3,icmp actions=set_queue:0,goto_table:1" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1,dl_src=$i, nw_dst=200.0.10.4, icmp actions=drop" -O Openflow13

							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"x\", $appb_bw)" framework 2> /dev/null
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"x\", $appc_bw)" framework 2> /dev/null
							#recalc balance
							rsu_calc=$rsu
							x=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc
						fi 
					done
				else
					echo "only blocking redirection traffic to this RAN..."
				fi
				rsu_calc=$rsu
				x=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2)
				calc 
			done
		#In case of RSU2 in analisis (script of RSU2)
		elif [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]] && [[ $rsu = "rsu2" ]]; then
			#while the balance is negative in RSU2
			while [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; do
				#identify MAC s in RSU2
				#mac_rsu1=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
				mac_rsu1=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2 )
				#If MACs are associetad to Apps B or C and arent blocked or limited, save information in respective files
				rm -f appc.txt
				rm -f appb.txt				
				for i in $mac_rsu1;
				do
					res_c=$(mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"C"'" framework 2> /dev/null |tail -1)
					res_b=$(mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"B"'" framework 2> /dev/null |tail -1)
					red_c=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where mac='"$i"' and rsu_o='"$rsu"' and bw_value=$appc_bw" 2> /dev/null framework | tail -1)
					red_b=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where mac='"$i"' and rsu_o='"$rsu"' and bw_value=$appb_bw" 2> /dev/null framework | tail -1)
					if [ $res_b != "NULL" ] && [ $red_b = "NULL" ]; then
						echo $i >> appb.txt
					fi
					if [ $res_c != "NULL" ] && [ $red_c = "NULL" ];
						then echo $i >> appc.txt;
					fi
				 done
				#To Neighbor RSU1, verify if it accept application C and there is MAC in local RAN associetad to C app
				if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -ge $appc_bw ]] && [[ $(cat appc.txt | wc -l) -gt 0 ]]; then
					for i in $(cat appc.txt);
					do
						#While there is balance in neigbor to support some C application and RSU2 has negative balance with C app
						if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -ge $appc_bw ]] && [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]] ; then
							#Control message
							echo -e "\n $rsu congested. RSU1 can deal with at least one C applications. C applcations will be redirected until there is balance."
							echo $i " is associetad to an C application"
							echo "redirect " $i " from $rsu to rsu1"
							#Redirect data of C application from RSU2 to RSU1. Install flows in source, destination and backbone
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=2" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.4, icmp actions=2" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=2, dl_dst=$i, icmp actions=1" -O Openflow13

							ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=3" -O Openflow13
							# ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3,dl_dst=$i, udp,tp_src=5004 actions=2" -O Openflow13
							ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2,dl_src=$i, nw_dst=200.0.10.4, icmp actions=3" -O Openflow13
							ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3,dl_dst=$i, icmp actions=2" -O Openflow13	
							
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=2,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=1" -O Openflow13
							# ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1,dl_dst=$i, udp,tp_src=5004 actions=2" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=2,dl_src=$i, nw_dst=200.0.10.4, icmp actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1,dl_dst=$i, icmp actions=2" -O Openflow13

							#Delete flows in backbone - enable only in automatic moving of vehicles (with mobility script)
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
							#register information in database
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"rsu1\", $appc_bw)" framework 2> /dev/null
							#recalc balance in neighbor (rsu1) an rsu in analisis (rsu2)
							rsu_calc=rsu1
							x=$(iw dev rsu1-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc 
							rsu_calc=$rsu
							x=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc
						fi
					done
					#To neighbor rsu3, verify if it can deal with at least one C application, if yet there is appc in local RAN
				elif [[ $(cat saldo.txt | grep rsu3 | cut -d' ' -f2) -ge $appc_bw ]] && [[ $(cat appc.txt | wc -l) -gt 0 ]]; then
					for i in $(cat appc.txt);
					do
						#While there is balance in neighbor to support some C application and local RSU is with negative balance 
						if [[ $(cat saldo.txt | grep rsu3 | cut -d' ' -f2) -ge $appc_bw ]] && [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]] ; then
							#Print control messages
							echo -e "\n $rsu congested. RSU3 can deal with at least one C application. C applications will be redirected until there is enough balance."
							echo $i " is associetad with an C application"
							echo "redirect  " $i " from $rsu to rsu3"
							#Redirect data of C app from RSU2 to RSU3. Install flows high priority in source, destination and backbone
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=3" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.4, icmp actions=3" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_dst=$i, icmp actions=1" -O Openflow13
							
							ovs-ofctl add-flow rsu3 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=3" -O Openflow13
							# ovs-ofctl add-flow rsu3 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3,dl_dst=$i, udp,tp_src=5004 actions=2" -O Openflow13
							ovs-ofctl add-flow rsu3 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2,dl_src=$i, nw_dst=200.0.10.4, icmp actions=3" -O Openflow13
							ovs-ofctl add-flow rsu3 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3,dl_dst=$i, icmp actions=2" -O Openflow13

							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=1" -O Openflow13
							# ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1,dl_dst=$i, udp,tp_src=5004 actions=4" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4,dl_src=$i, nw_dst=200.0.10.4, icmp actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1,dl_dst=$i, icmp actions=4" -O Openflow13
							#Delete flows in backbone - enable only in automatic moving of vehicles (with mobility script)
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
							#register information in database
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"rsu3\", $appc_bw)" framework 2> /dev/null
							#recalc balance in local and neighbor rsu
							rsu_calc=rsu3
							x=$(iw dev rsu3-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc 
							rsu_calc=$rsu
							x=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc
						fi
					done			
				#If neighbor (RSU1) can deal with at least one B application and there is A application in RAN	
				elif [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -ge $appb_bw ]] && [[ $(cat appb.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appb.txt);
					do
						#check for each app if the balance still is negative and neighbor still can deal with B application
						if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -ge $appb_bw ]] && [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; then
							#Control message
							echo -e "\n $rsu still congested. RSU1 suports at least one B application. B applications will be redirected until there is balance"
							echo $i " is associated to an B application"
							echo "redirect " $i " from $rsu to rsu2"
							#Redirect data of B application, from RSU2 to RSU1
							#Install flows in source rsu, destination and backbone with high priority
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=2" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.3, icmp actions=2" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=2, dl_dst=$i, icmp actions=1" -O Openflow13

							ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=3" -O Openflow13
							# ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_dst=$i, udp, tp_src=5003 actions=2" -O Openflow13
							ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2, dl_src=$i, nw_dst=200.0.10.3, icmp actions=3" -O Openflow13
							ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_dst=$i, icmp actions=2" -O Openflow13
							
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=2, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=1" -O Openflow13
							# ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_dst=$i, udp, tp_src=5003 actions=2" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=2, dl_src=$i, nw_dst=200.0.10.3, icmp actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_dst=$i, icmp actions=2" -O Openflow13

							#Delete flows in backbone - enable only in automatic moving of vehicles (with mobility script)
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
							#register information in database
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"rsu1\", $appb_bw)" framework 2> /dev/null
							#Recalc balances
							rsu_calc=rsu1
							x=$(iw dev rsu1-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc 
							rsu_calc=$rsu
							x=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc
						fi
					done
				#If neighbor (RSU3) has balance to deal with t least one B application and there is B application in local RAN	
				elif [[ $(cat saldo.txt | grep rsu3 | cut -d' ' -f2) -ge $appb_bw ]] && [[ $(cat appb.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appb.txt);
					do
						#sCheck balance for each B app
						if [[ $(cat saldo.txt | grep rsu3 | cut -d' ' -f2) -ge $appb_bw ]] && [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; then
							#control message
							echo -e "\n $rsu still congested. RSU3 support at least one B application. B applications will be redirected until negative balance"
							echo $i " is associeted to an B application"
							echo "redirect " $i " from $rsu to rsu3"
							#Redirect data of App B from RSU2 to RSU3. Install respective flows in source, destination and backbone and update database
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.3, udp,tp_dst=5003 actions=3" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.3, icmp actions=3" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_dst=$i, icmp actions=1" -O Openflow13

							ovs-ofctl add-flow rsu3 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2, dl_src=$i, nw_dst=200.0.10.3, udp,tp_dst=5003 actions=3" -O Openflow13
							# ovs-ofctl add-flow rsu3 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_dst=$i, udp,tp_src=5003 actions=2" -O Openflow13
							ovs-ofctl add-flow rsu3 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2, dl_src=$i, nw_dst=200.0.10.3, icmp actions=3" -O Openflow13
							ovs-ofctl add-flow rsu3 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_dst=$i, icmp actions=2" -O Openflow13
							
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4, dl_src=$i, nw_dst=200.0.10.3, udp,tp_dst=5003 actions=1" -O Openflow13
							# ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_dst=$i, udp,tp_src=5003 actions=4" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4, dl_src=$i, nw_dst=200.0.10.3, icmp actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_dst=$i, icmp actions=4" -O Openflow13
							#Delete flows in backbone - enable only in automatic moving of vehicles (with mobility script)
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
							#register information in database
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"rsu3\", $appb_bw)" framework 2> /dev/null
							#Recalc balance of source and destinatio RSUs to update reference files
							rsu_calc=rsu3
							x=$(iw dev rsu3-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc 
							rsu_calc=$rsu
							x=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc
						fi
					done
				#Verify the possibility to limit C applications
				elif [[ $(cat appc.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appc.txt);
					do				
						if [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; then
							echo -e "\n $rsu is still congested. RSU1 does not have avaiable balance. C applications will be limited."
							echo $i " is associated to an C application and will be limited. Internet also will be blocked"
							echo "limiting " $i " in $rsu..."
							#Install flows to limit C application and block general traffic in RAN. Update Database also.
							ovs-ofctl add-flow $rsu "table=0, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.4, udp, tp_dst=5004 actions=set_queue:0,goto_table:1" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, nw_dst=200.0.10.5, udp,tp_dst=5005 actions=drop" -O Openflow13
							
							ovs-ofctl add-flow $rsu "table=0, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.4, icmp actions=set_queue:0,goto_table:1" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, nw_dst=200.0.10.5, icmp actions=drop" -O Openflow13

							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"x\", $appc_bw)" framework 2> /dev/null
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"internet\", \"$rsu\", \"x\", 0)" framework 2> /dev/null
							#recalc balance
							rsu_calc=$rsu
							x=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc 
						fi
					done
				#Verify the possibility to limit the redirects of C applications in order to not limit B applications
				elif [[ $(mysql -u root -pwifi -e "select mac from redirect where rsu_o='"$rsu"' and bw_value=$appc_bw and rsu_dest!='"x"'" framework 2> /dev/null | grep -v mac | tail -1 | grep : -c ) -gt 0 ]]; then
					echo -e "\n $rsu still congested. RSUs 1 and 3 have no availabe balance. C applications that was redirected will be locally limited until there is balance in neighbor."
					#Identify C applications previously redirected and respective destination. Print control message
					i=$(mysql -u root -pwifi -e "select mac from redirect where rsu_o='"$rsu"' and bw_value=$appc_bw and rsu_dest!='"x"'" framework 2> /dev/null | grep -v mac | tail -1)
					rsudst=$(mysql -u root -pwifi -e "select rsu_dest from redirect where rsu_o='"$rsu"' and mac='"$i"' and bw_value=$appc_bw" framework 2> /dev/null | grep -v dst | tail -1)
					echo "C application in $i was redirected and will be locally limited. Internet also will be blocked"
					#Limit C application in local RAN and block internet also. Delete flows related to previous redrection and update db register
					ovs-ofctl add-flow $rsu "table=0, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.4, udp, tp_dst=5004 actions=set_queue:0,goto_table:1" -O Openflow13
					ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)8, in_port=1, nw_dst=200.0.10.5, udp,tp_dst=5005 actions=drop" -O Openflow13

					ovs-ofctl add-flow $rsu "table=0, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.4, icmp actions=set_queue:0,goto_table:1" -O Openflow13
					ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)8, in_port=1, nw_dst=200.0.10.5, icmp actions=drop" -O Openflow13

					ovs-ofctl del-flows $rsu cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,udp,tp_dst=5004 -O Openflow13
					ovs-ofctl del-flows $rsu cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,icmp -O Openflow13
					ovs-ofctl del-flows $rsu cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$i,icmp -O Openflow13

					ovs-ofctl del-flows $rsudst cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,udp,tp_dst=5004 -O Openflow13
					ovs-ofctl del-flows $rsudst cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,icmp -O Openflow13
					ovs-ofctl del-flows $rsudst cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$i,icmp -O Openflow13

					ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,udp,tp_dst=5004 -O Openflow13
					ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,icmp -O Openflow13
					ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$i,icmp -O Openflow13
					mysql -u root -pwifi -e "update redirect set rsu_dest=\"x\" where mac=\"$i\" and bw_value=$appc_bw" framework 2> /dev/null
					mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"internet\", \"$rsu\", \"b\", 0)" framework 2> /dev/null
					#recalc balance
					rsu_calc=$rsudst
					x=$(iw dev $rsudst-wlan1 station dump | grep wlan | cut -d' ' -f2)
					calc

				#Last case, limit B applications
				elif [[ $(cat appb.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appb.txt);
					do
						if [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; then
							echo -e "\n $rsu still congested. RSUs 1 and 3 are withou available balance. No actions in C applications. B applications will be limited and C blocked until there is balance."
							echo $i " is associated to an B application and will be limited. C will be blocked"
							echo "limiting " $i " in $rsu..."					
							#Install flow to limit application B in RAN and block C Application of vehicle and register in database. Recalc balance
							ovs-ofctl add-flow $rsu "table=0, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=set_queue:0,goto_table:1" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=drop" -O Openflow13
							
							ovs-ofctl add-flow $rsu "table=0, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.3, icmp actions=set_queue:0,goto_table:1" -O Openflow13
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1,dl_src=$i, nw_dst=200.0.10.4, icmp actions=drop" -O Openflow13
							
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"x\", $appb_bw)" framework 2> /dev/null
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"x\", $appc_bw)" framework 2> /dev/null
							rsu_calc=$rsu
							x=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2)
							calc
						fi 
					done
				else
					echo "Just blocking redirection flows to this RAN...."
				fi
				#Recalc balance
				rsu_calc=$rsu
				x=$(iw dev $rsu-wlan1 station dump | grep wlan | cut -d' ' -f2)
				calc
			done		
		else
			#verify if internet is blocked at RAN and unblock, since the balance is positive

			for j in $(ifconfig | grep wlan | cut -d' ' -f1);
			do
				#identify rsu
				rsu=$(echo $j | cut -d'-' -f1)
				#Identify MACs of vehicles in rsu
				x=$(iw dev $j station dump | grep wlan | cut -d' ' -f2)
				rsu_calc=$rsu
				calc
				internet_test=""
				internet_test=$(mysql -u root -pwifi -e "select * from redirect where rsu_o= '"$rsu"' and mac='"internet"' " framework 2> /dev/null | grep -v mac)

				if [[ $(echo $y|bc) -lt $up ]] && [[ $internet_test != "" ]]; then
					echo "internet was blocked in " $rsu ". As demand balance is positive, it will be unblocked";
					#Erase flows in source RSU and the information in database
					ovs-ofctl del-flows $rsu cookie=0x$(echo $rsu | cut -d'u' -f2)8/-1 -O Openflow13
					mysql -u root -pwifi -e "delete from redirect where mac  = \"internet\" and rsu_o = \"$rsu\"" framework 2> /dev/null
				fi
			done
		fi
	done
	sleep $t
done