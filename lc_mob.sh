#!/bin/bash

#aplicação generica para gerenciamento de mobilidade ente celulas

while true;
do
	#RSU1 verifica se existem flow no backbone correto para os veiculos em sua RAN
	p=2
	for i in $(hostapd_cli -i rsu1-wlan1 all_sta | grep :);
	do
		x=$(ovs-ofctl dump-flows sw1 -O Openflow13 | grep dl_dst=$i | grep output:$p | grep 0x0 -c)
		if  [[ $x -lt 1 ]]; then
			echo "falta RSU1 " $i
			echo "Configurando..."
			ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
			ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
			ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=$p,dl_src=$i actions=1" -O Openflow13
			ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=$i actions=$p" -O Openflow13
			echo "Concluído!"
		fi
	done

	#RSU2 verifica se existem flow no backbone correto para os veiculos em sua RAN
	p=3
	for i in $(hostapd_cli -i rsu2-wlan1 all_sta | grep :);
	do
		x=$(ovs-ofctl dump-flows sw1 -O Openflow13 | grep dl_dst=$i | grep output:$p | grep 0x0 -c)
		if  [[ $x -lt 1 ]]; then
			echo "falta na RSU2 " $i
			echo "Configurando..."
			ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
			ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
			ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=$p,dl_src=$i actions=1" -O Openflow13
			ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=$i actions=$p" -O Openflow13
			echo "Concluído!"
		fi
	done

	#RSU3 verifica se existem flow no backbone correto para os veiculos em sua RAN
	p=4
	for i in $(hostapd_cli -i rsu3-wlan1 all_sta | grep :);
	do
		x=$(ovs-ofctl dump-flows sw1 -O Openflow13 | grep dl_dst=$i | grep output:$p | grep 0x0 -c)
		if  [[ $x -lt 1 ]]; then
			echo "falta na RSU3 " $i
			echo "Configurando..."
			ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
			ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
			ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=$p,dl_src=$i actions=1" -O Openflow13
			ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=$i actions=$p" -O Openflow13
			echo "Concluído!"
		fi
	done
	sleep 3;
done



