#!/bin/bash

# mysql -u root -p$pass -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = \"00:00:00:00:00:01\")" framework

# x=$(mysql -u root -p$pass -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = \"00:00:00:00:00:03\")" framework | tail -1)

# os.system('ovs-ofctl del-flows sw1 -O Openflow13; ovs-ofctl add-flow sw1 "table=0, priority=0, actions=goto_table:1" -O Openflow13; ovs-ofctl add-flow sw1 "table=1, priority=0, actions=CONTROLLER:65535" -O Openflow13')

# for i in $x; do echo $i; mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"')" framework 2> /dev/null; done

#define capacidade dos links de upload em mbps
up=10000000

#Define a periodicidade em segundos, na qual os controladores verificam o status da rede local
t=2

while true;
do
	rm -f saldo.txt
	y=0
	#Para cada interface wlan de RSU identificada
	for j in $(ifconfig | grep wlan | cut -d' ' -f1);
	do
		#Identifica veiculos na RSU, buscando pelo MAC
		x=$(hostapd_cli -i $j all_sta | grep :)

		#se existem veículos na RAN, calcula saldo
		if [[ $(echo $x | wc -w) -gt 0 ]]; then

			#Busca na base de dados e salva em $y a soma dos valores de requisitos de banda dos veiculos na RSU
			y=$(
			for i in $x;
			do
				mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"')" framework 2> /dev/null |tail -1
			done | paste -s | expand | sed 's/ /+/g' | bc)

			# calcula o saldo da RSU, armazena em $sd e imprime na tela resultados
			sd=$(echo $up-$y|bc)
		else
		#se não tem veículos o saldo é o valor do link de backbone
		# if [[ $(echo $x | wc -w) -eq 0 ]]; then
			sd=$up
		fi

		echo -e "\n " $(echo $j | cut -d'-' -f1) " tem ocupado " $(echo $y|bc) " e saldo de " $sd ". " $(echo $x| wc -w) " veiculos"
		echo $(echo $j | cut -d'-' -f1) $sd >> saldo.txt

	done

	sleep $t
done

#Se o saldo da RSU é menor que zero informa redirecionamento
			# if [[ $sd -lt 0 ]]; then
			# 	echo -e "\n Redirecionando"
			# 	for j in $(ifconfig | grep wlan | cut -d' ' -f1);
			# 	do
			# 		if [[ $(cat saldo.txt | grep $j -c) -eq 0 ]]; then
			# 			echo $j " esta livre"
			# 		fi
					
			# 	done
			# fi

#Visto que o controlador local efetivamente controla no máximo os switchwes diretamente conectados, sendo os de upload e os das RSUs vizinhas, na implementação esse controle
#foi implementado através de código executando instruções com a ferramenta ovs-ofctl localmente nos openvswitches

#De tempos em tempos consulta a base de dados para o enforcement das politicas. Não haverá comunicação direta com o controlador central

#enquanrto os switches locais sao controlados apenas pelos lc o de backbone e por todo mundo  so o de upload

#quando estiver redirecionando um tráfego, o controlador tem que contabilizar esse tráfego do veiculo que não está em ua RAN como consumindo o backbone