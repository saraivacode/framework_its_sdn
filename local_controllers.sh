#!/bin/bash

# mysql -u root -p$pass -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = \"00:00:00:00:00:01\")" framework

# x=$(mysql -u root -p$pass -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = \"00:00:00:00:00:03\")" framework | tail -1)

# os.system('ovs-ofctl del-flows sw1 -O Openflow13; ovs-ofctl add-flow sw1 "table=0, priority=0, actions=goto_table:1" -O Openflow13; ovs-ofctl add-flow sw1 "table=1, priority=0, actions=CONTROLLER:65535" -O Openflow13')

# for i in $x; do echo $i; mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"')" framework 2> /dev/null; done

#define capacidade dos links de upload em mbps
up=3000000

#Define a periodicidade em segundos, na qual os controladores verificam o status da rede local
t=5

function calc {

	#se tem veiculo na RAN
	if [[ $(echo $x | wc -w) -gt 0 ]]; then
		y=$(
		for i in $x;
		do
			mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"')" framework 2> /dev/null |tail -1
		done | paste -s | expand | sed 's/ /+/g' | bc)		

		b=$(
		for i in $x;
		do
			mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"B"'" framework 2> /dev/null |tail -1
		done | paste -s | expand | sed 's/ /+/g' | bc)

		c=$(
		for i in $x;
		do
			mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"C"'" framework 2> /dev/null |tail -1
		done | paste -s | expand | sed 's/ /+/g' | bc)
	fi

	dec=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where rsu_dest= '"$rsu"' " framework 2> /dev/null | tail -1)
	inc=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where rsu_o= '"$rsu"' " framework 2> /dev/null | tail -1)

	if [ $inc = "NULL" ]; then
		inc=0
	fi

	if [ $dec = "NULL" ]; then
		dec=0
	fi					

	sd=$(echo $up-$y-$dec+$inc|bc)
	# echo -e "\n rsu: " $rsu " dec: " $dec " inc: " $inc " sd: " $sd
}

while true;
do
	rm -f saldo.txt
	#Para cada interface wlan de RSU identificada
	for j in $(ifconfig | grep wlan | cut -d' ' -f1);
	do
		#nome da rsu em análise
		rsu=$(echo $j | cut -d'-' -f1)

		#Identifica veiculos na RSU, buscando pelo MAC
		x=$(hostapd_cli -i $j all_sta | grep :)

		#identifica macs em redirecionamento cuja rsu local foi origem
		mac_rec=$(mysql -u root -pwifi -e "select mac from redirect where rsu_o= '"$rsu"' " framework 2> /dev/null | grep -v mac)

		#Verifica se esses MACs na base ainda estao na RAN local e os apaga da tabela em caso negativo, deletando os respectivos flows
		for m in $mac_rec; do
			if [[ $(hostapd_cli -i $j all_sta | grep $m -c) -eq 0 ]]; then
				echo -e "\n Apagando MAC indevido " $m" em " $rsu
				mysql -u root -pwifi -e "delete from redirect where mac  = \"$m\" and rsu_o = \"$rsu\"" framework 2> /dev/null
				#Falta apagar os flows
			fi
		done

		#quantidade de registros sobre a rsu na tabela
		r=$(mysql -u root -pwifi -e "select * from redirect" framework 2> /dev/null | grep -c $rsu)
			if [ $r = "NULL" ]; then
				r=0
			fi

		#inicializa valores de saldo para celulas vazias
		sd=$up
		y=0
		b=0
		c=0
		inc=0
		dec=0

		#se existem veiculos ou registro de redirecionamento para RAN, calcula saldo
		if [[ $(echo $x | wc -w) -gt 0 ]] || [[ $r -gt 0 ]]; then
			#echo "calculando para " $rsu
			calc
		# 	#Busca na base de dados e salva em $y a soma dos valores de requisitos de banda dos veiculos na RSU
		# 	y=$(
		# 	for i in $x;
		# 	do
		# 		mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"')" framework 2> /dev/null |tail -1
		# 	done | paste -s | expand | sed 's/ /+/g' | bc)

		# 	b=$(
		# 	for i in $x;
		# 	do
		# 		mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"B"'" framework 2> /dev/null |tail -1
		# 	done | paste -s | expand | sed 's/ /+/g' | bc)

		# 	c=$(
		# 	for i in $x;
		# 	do
		# 		mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"C"'" framework 2> /dev/null |tail -1
		# 	done | paste -s | expand | sed 's/ /+/g' | bc)

		# 	dec=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where rsu_dest= '"$rsu"' " framework 2> /dev/null | tail -1)
		# 	inc=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where rsu_o= '"$rsu"' " framework 2> /dev/null | tail -1)

		# 	if [ $inc = "NULL" ]; then
		# 		inc=0
		# 	fi

		# 	if [ $dec = "NULL" ]; then
		# 		dec=0
		# 	fi

		# 	# calcula o saldo da RSU, armazena em $sd e imprime na tela resultados
		# 	sd=$(echo $up-$y-$dec+$inc|bc)			
		fi

		# echo -e "\n" $(echo $j | cut -d'-' -f1) " tem ocupado " $(echo $y|bc) " ($b com B e $c com C) " " e saldo de " $sd ". " $(echo $x| wc -w) " veiculos"
		echo -e $rsu " tem ocupado " $(echo $y|bc) " dec: " $dec " inc: " $inc " sd: " $sd ". " $(echo $x| wc -w) " veiculos. r " $r
		echo $(echo $j | cut -d'-' -f1) $sd >> saldo.txt

	done
	echo -e "\n =========================================//==============================================================="

	#para cada rsu no arquivo de saldos
	# for i in $(cat saldo.txt | cut -d' ' -f1); do

	# 	#se o saldo e menor que zero
	# 	# if [[ $(cat saldo.txt | grep $i | cut -d' ' -f2) -lt 0 ]]; then
	# 	# 	#statements
	# 	# 	#se consegue ao menos atender as aplicações B
	# 	# 	if [[ $b -lt $up ]]; then
	# 	# 		#statements

	# 	# 		macc=$(mysql -u root -pwifi -e "select mac from vehicle where app_id in (select id from appkpi where class='"C"')" framework 2> /dev/null)

	# 	# 		for i in $macc; do
	# 	# 			#statements
	# 	# 			echo -e "/n Redireciona " $i
	# 	# 			mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"rsu2\", \"rsu1\", 3000000)" framework
	# 	# 			calc
	# 	# 		done
	# 	# 	fi

	# 		if [[ $i = "rsu1" ]]; then
	# 			#statements
	# 			# if [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $(cat saldo.txt | grep $i | cut -d'-' -f2) ]]; then
	# 			if [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge 0 ]]; then
	# 				#statements
	# 				echo -e "\n RSU1 congestionada. Redireciona para RSU2"
	# 				# mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"00:00:00:00:00:02\", \"rsu2\", \"rsu1\", 23450000)" framework
	# 			else
	# 				echo -e "\n RSU1 congestionada. RSU2 ocupada. Nao tem jeito"
	# 			fi
	# 		fi

	# 		if [[ $i = "rsu3" ]]; then
	# 			#statements
	# 			# if [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $(cat saldo.txt | grep $i | cut -d'-' -f2) ]]; then
	# 			if [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge 0 ]]; then
	# 				#statements
	# 				echo -e "\n RSU3 congestionada. Redireciona para RSU2"

	# 			else
	# 				echo -e "\n RSU3 congestionada. RSU2 ocupada. Nao tem jeito"
	# 			fi
	# 		fi

	# 		if [[ $i = "rsu2" ]]; then
	# 			#statements
	# 			# if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -ge $(cat saldo.txt | grep $i | cut -d'-' -f2) ]]; then
	# 			if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -ge 0 ]]; then
	# 				#statements
	# 				echo -e "\n RSU2 congestionada. Redireciona para RSU1"
	# 			# elif [[ $(cat saldo.txt | grep rsu3 | cut -d' ' -f2) -ge $(cat saldo.txt | grep $i | cut -d'-' -f2) ]]; then
	# 			if [[ $(cat saldo.txt | grep rsu3 | cut -d' ' -f2) -ge 0 ]]; then
	# 					#statements
	# 					echo -e "\n RSU2 congestionada. Redireciona para RSU3"
	# 			else
	# 				echo -e "\n RSU2 congestionada. RSUs 1 e 3 ocupadas. Nao tem jeito"
	# 			fi
	# 		fi
	# 	fi

	# done

	sleep $t
done


#Visto que o controlador local efetivamente controla no máximo os switchwes diretamente conectados, sendo os de upload e os das RSUs vizinhas, na implementação esse controle
#foi implementado através de código executando instruções com a ferramenta ovs-ofctl localmente nos openvswitches

#De tempos em tempos consulta a base de dados para o enforcement das politicas. Não haverá comunicação direta com o controlador central

#enquanto os switches locais sao controlados apenas pelos lc o de backbone e por todo mundo  so o de upload

#quando estiver redirecionando um tráfego, o controlador tem que contabilizar esse tráfego do veiculo que não está em ua RAN como consumindo o backbone