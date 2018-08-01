#!/bin/bash

# mysql -u root -p$pass -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = \"00:00:00:00:00:01\")" framework

# x=$(mysql -u root -p$pass -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = \"00:00:00:00:00:03\")" framework | tail -1)

# os.system('ovs-ofctl del-flows sw1 -O Openflow13; ovs-ofctl add-flow sw1 "table=0, priority=0, actions=goto_table:1" -O Openflow13; ovs-ofctl add-flow sw1 "table=1, priority=0, actions=CONTROLLER:65535" -O Openflow13')

# for i in $x; do echo $i; mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"')" framework 2> /dev/null; done

#define capacidade dos links de upload em mbps
up=6000000

#Define a periodicidade em segundos, na qual os controladores verificam o status da rede local
t=5
appb_bw=1000000
appc_bw=3000000

#Funcao que calcula saldo
function calc {

	#se tem veiculo na RAN
	if [[ $(echo $x | wc -w) -gt 0 ]]; then
		#calcula consumo com base nos MACs dos veiculos na RAN
		y=$(
		for i in $x;
		do
			mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"')" framework 2> /dev/null |tail -1
		done | paste -s | expand | tr -s ' ' | sed 's/ /+/g' |sed 's/NULL/0/g'| bc)	

		#calcula consumo especifico das aplicações B
		b=$(
		for i in $x;
		do
			mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"B"'" framework 2> /dev/null |tail -1
		done | paste -s | expand | tr -s ' ' | sed 's/ /+/g' |sed 's/NULL/0/g'| bc)

		#calcula consumo especifico das aplicações C
		c=$(
		for i in $x;
		do
			mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"C"'" framework 2> /dev/null |tail -1
		done | paste -s | expand | tr -s ' ' | sed 's/ /+/g' |sed 's/NULL/0/g'| bc)

	fi

	#Verifica se existem fluxos cadastrados cuja RSUS em análise é destino (para debitar do saldo)
	dec=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where rsu_dest= '"$rsu"' " framework 2> /dev/null | tail -1)
	#Verifica se esxistem fluxos cadastrados cuja RSUS em análise é origem (para incrementar do saldo)
	inc=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where rsu_o= '"$rsu"' " framework 2> /dev/null | tail -1)

	#quando o resultado das funções anteriores é nulo transforma em 0 para efetuar os calculos posteriores
	if [ $inc = "NULL" ]; then
		inc=0
	fi

	if [ $dec = "NULL" ]; then
		dec=0
	fi					

	#Calcula o saldo da RSU em análise
	sd=$(echo $up-$y-$dec+$inc|bc)
	#echo -e "\n rsu: " $rsu " dec: " $dec " inc: " $inc " sd: " $sd "y: " $y

	#Salva saldo calculado em arquivo temporario de controle, para uso nos demais passos
	cat saldo.txt | grep -v $rsu > temp.tmp
	echo $rsu $sd >> temp.tmp
	rm saldo.txt
	mv temp.tmp saldo.txt
	#echo $(echo $j | cut -d'-' -f1) $sd >> saldo.txt
}

while true;
do
	#zera arquivo de saldos que será utilizado como referência
	rm -f saldo.txt
	touch saldo.txt

	#Para cada interface wlan de cada RSU no ambiente de analise
	for j in $(ifconfig | grep wlan | cut -d' ' -f1);
	do
		#separa o nome da rsu na interface em analise
		rsu=$(echo $j | cut -d'-' -f1)

		#Identifica MACs dos veiculos na RSU
		x=$(hostapd_cli -i $j all_sta | grep :)

		#identifica MACs em redirecionamento cuja rsu local seja origem (verificar...)
		mac_rec=$(mysql -u root -pwifi -e "select mac from redirect where rsu_o= '"$rsu"' " framework 2> /dev/null | grep -v mac)

		#Verifica se esses MACs na base ainda estao na RAN local e os apaga da tabela (desfazendo as configuracoes relacionadas - ex. flows) em caso negativo
		for m in $mac_rec;
		do
			if [[ $(hostapd_cli -i $j all_sta | grep $m -c) -eq 0 ]]; then
				echo -e "\n Apagando MAC indevido " $m" em " $rsu
				mysql -u root -pwifi -e "delete from redirect where mac  = \"$m\" and rsu_o = \"$rsu\"" framework 2> /dev/null
				#Falta apagar os flows
				if [[ $rsu = "rsu1" ]]; then
					ovs-ofctl del-flows rsu1 cookie=0x10/-1,dl_dst=$m -O Openflow13
					ovs-ofctl del-flows rsu1 cookie=0x10/-1,dl_src=$m -O Openflow13
					ovs-ofctl del-flows rsu1 cookie=0x15/-1,dl_src=$m -O Openflow13
					ovs-ofctl del-flows rsu2 cookie=0x10/-1,dl_dst=$m -O Openflow13
					ovs-ofctl del-flows rsu2 cookie=0x10/-1,dl_src=$m -O Openflow13
					ovs-ofctl del-flows sw1 cookie=0x10/-1,dl_dst=$m -O Openflow13
					ovs-ofctl del-flows sw1 cookie=0x10/-1,dl_src=$m -O Openflow13
				fi
			fi
		done

		#verifica se existe registro de redirecionamento relacionado a RAN em analise (motivo para calcular saldo)
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
		
		#salva valores no arquivo temporario de controle
		cat saldo.txt | grep -v $rsu > temp.tmp
		echo $rsu $up >> temp.tmp
		rm saldo.txt
		mv temp.tmp saldo.txt

		#se existem veiculos ou registro de redirecionamento para RAN, calcula saldo
		if [[ $(echo $x | wc -w) -gt 0 ]] || [[ $r -gt 0 ]]; then
			calc			
		fi

		#Imprime resultado dos calculos de saldo na tela
		echo -e $rsu " tem ocupado " $(echo $y|bc)   " ($b com B e $c com C)." " dec: " $dec " inc: " $inc " sd: " $sd ". " $(echo $x| wc -w) "veiculos. r " $r
	done
	echo -e "\n =========================================//==============================================================="

	####################Parte 2 do codigo, que lida com a parte dos redirecionamentos

	#para cada rsu no arquivo de saldos
	for i in $(cat saldo.txt | cut -d' ' -f1);
	do
	# 	#se o saldo for menor que zero (precisa de acao)
	 	if [[ $(cat saldo.txt | grep $i | cut -d' ' -f2) -lt 0 ]]; then
			#se for a rsu1 em analise (que tem apenas como vizinha a rsu2) - aqui se perde a escalabilidade da implementacao
			if [[ $i = "rsu1" ]]; then
				#enquanto o saldo for negativo na RSU1
				while [[ $(cat saldo.txt | grep $i | cut -d' ' -f2) -lt 0 ]]; do
					#identifica os MACs na RSU1
					mac_rsu1=$(hostapd_cli -i rsu1-wlan1 all_sta | grep :)
					# verifica se rsu2 (vizinha) consegue ao menos suportar uma aplicação C (primeiras a serem redirecionadas, em função dos requisitos)
					if [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $appc_bw ]]; then
						#Imprime na tela mensagem de controle
						echo -e "\n RSU1 congestionada. RSU2 suporta ao menos uma aplicação C"
							#sPara cada mac (veiculo) na rsu1, verifica se está associado a aplicação C
						for i in $mac_rsu1;
						do
							#Se tiver saldo no vizinho (rsu2) para suportar alguma aplicação C e o saldo da rsu1 ainda estiver negativo
							if [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $appc_bw ]] && [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -lt 0 ]] ; then
							#variavel para verificar se veiculo com MAC analisado possui aplicação C (só serve para uma)
								res_c=$(mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"C"'" framework 2> /dev/null |tail -1)
							#variavel para verificar o MAC em questão já não foi redirecionado
								red_c=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where mac='"$i"' and rsu_o='"rsu1"'" 2> /dev/null framework | tail -1)
								#se MAC é de aplicação C, nao foi redirecionado e o saldo da RAN local ainda e negativo, redireciona
								if [[ $res_c -ne "NULL" ]] && [[ $red_c = "NULL" ]] && [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -lt 0 ]]; then
									echo $i " esta associado a aplicacao C"
									echo "redireciona " $i " de rsu1 para rsu2"
									#Redireciona tráfego de aplicação C, da RSU1 para RSU2
									#insere flows na rsu origem de maior prioridade
									ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x10, in_port=1, dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=2" -O Openflow13
									ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x10, dl_dst=$i actions=1" -O Openflow13
									#Insere flows na RSU de redirecionamento
									ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x10 ,in_port=2,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=4" -O Openflow13
									ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x10, in_port=4,dl_dst=$i actions=2" -O Openflow13
									#Insere flows de maior prioridade no backbone
									ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x10, in_port=3,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=1" -O Openflow13
									ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x10, in_port=1,dl_dst=$i, udp,tp_src=5004 actions=3" -O Openflow13
									#Deleta flows no backbone para evitar confusao
									ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
									ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
									#cadastra na banco a informacao do redirecionamento
									mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"rsu1\", \"rsu2\", $appc_bw)" framework 2> /dev/null
									#Recalcula saldos da rsu local e de redirecionamento
									rsu=rsu2
									x=$(hostapd_cli -i rsu2-wlan1 all_sta | grep :)
									calc 
									rsu=rsu1
									x=$(hostapd_cli -i rsu1-wlan1 all_sta | grep :)
									calc
								fi
							fi
						done
						#se a RSU1 continua congestionada e o vizinho não suporta aplicacao C, verifica se suporta B
					elif [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $appb_bw ]]; then
						#mensagem de controle
						echo -e "\n RSU1 continua congestionada. RSU2 suporta ao menos uma aplicacao B."
						#Se vizinho suporta ao menos uma aplicação B e o saldo da RSU em analise ainda esta negativo
						if [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $appb_bw ]] && [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -lt 0 ]]; then
							for i in $mac_rsu1;
							do
								#variavel para verificar se veiculo com MAC analisado possui aplicação B (só serve para uma)
								res_b=$(mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"B"'" framework 2> /dev/null |tail -1)
								#variavel para verificar o MAC em questão já não foi redirecionado
								red_b=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where mac='"$i"' and rsu_o='"rsu1"'" 2> /dev/null framework | tail -1)
								#se MAC é de aplicação B, nao foi redirecionado e o saldo da RAN local ainda e negativo, redireciona
								if [[ $res_b -ne "NULL" ]] && [[ $red_b = "NULL" ]] && [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -lt 0 ]]; then
									echo $i " esta associado a aplicacao B"
									echo "redireciona " $i " de rsu1 para rsu2"
									#Redireciona tráfego de aplicação B, da RSU1 para RSU2
									#insere flows na rsu origem de maior prioridade
									ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x10, in_port=1, dl_src=$i, nw_dst=200.0.10.3, udp,tp_dst=5003 actions=2" -O Openflow13
									ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x10, dl_dst=$i actions=1" -O Openflow13
									#Insere flows na RSU de redirecionamento
									ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x10 ,in_port=2,dl_src=$i, nw_dst=200.0.10.3, udp,tp_dst=5003 actions=4" -O Openflow13
									ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x10, in_port=4,dl_dst=$i actions=2" -O Openflow13
									#Insere flows de maior prioridade no backbone
									ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x10, in_port=3,dl_src=$i, nw_dst=200.0.10.3, udp,tp_dst=5003 actions=1" -O Openflow13
									ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x10, in_port=1,dl_dst=$i, udp,tp_src=5003 actions=3" -O Openflow13
									#Deleta flows no backbone para evitar confusao
									ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
									ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
									#cadastra redirecionamento no banco
									mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"rsu1\", \"rsu2\", $appb_bw)" framework
									#Recalcula saldos
									rsu=rsu2
									x=$(hostapd_cli -i rsu2-wlan1 all_sta | grep :)
									calc 
									rsu=rsu1
									x=$(hostapd_cli -i rsu1-wlan1 all_sta | grep :)
									calc 
								fi
							done
						fi
					else
						#caso a rsu ainda esteja congestionada e o vizinho não suporte nenhum redirecionamento, será necessário bloquear o que ainda nao foi redirecionado comecando por C
						#Imprime mensagem de controle
						echo -e "\n RSU1 congestionada. RSU2 ocupada. Nao tem jeito. Haverá bloqueios"
						#while [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -lt 0 ]]; do
						echo "verificando"
						for i in $mac_rsu1;
						do
							#Faz as verificacoes para saber se o MAC e de aplicacao C 
							res_c=$(mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"C"'" framework 2> /dev/null |tail -1)
							red_c=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where mac='"$i"' and rsu_o='"rsu1"'" 2> /dev/null framework | tail -1)
							if [[ $res_c != "NULL" ]] && [[ $red_c = "NULL" ]] && [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -lt 0 ]]; then
								echo $i " esta associado a aplicacao C e será bloqueada"
								echo "bloqueando " $i " em RSU1..."
								#bloqueia trafego
								ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x15, in_port=1,dl_src=$i actions=drop" -O Openflow13
								#cadastra na banco
								mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"rsu1\", \"x\", $appc_bw)" framework 2> /dev/null
								#envia flows
								rsu=rsu1
								x=$(hostapd_cli -i rsu1-wlan1 all_sta | grep :)
								calc 
							fi
						done
							#if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -lt 0 ]]; then
								
						for i in $mac_rsu1;
						do
							res_b=$(mysql -u root -pwifi -e "select sum(data_rate) from appkpi where id IN (select app_id from vehicle where mac = '"$i"') and class='"B"'" framework 2> /dev/null |tail -1)
							red_b=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where mac='"$i"' and rsu_o='"rsu1"'" 2> /dev/null framework | tail -1)
							if [[ $res_b != "NULL" ]] && [[ $red_b = "NULL" ]] && [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -lt 0 ]]; then
								echo "Aplicacoes B serao bloqueadas. saldo " $(cat saldo.txt | grep rsu1 | cut -d' ' -f2)
								echo $i " esta associado a aplicacao B e será bloqueada"
								echo "bloqueando " $i " em RSU1..."
								#bloqueia trafego (limitacao desbloquear caso a ran fique livre)
								ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x15, in_port=1,dl_src=$i actions=drop" -O Openflow13
								#cadastra na banco
								mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"rsu1\", \"x\", $appb_bw)" framework 2> /dev/null
								#envia flows
								rsu=rsu1
								x=$(hostapd_cli -i rsu1-wlan1 all_sta | grep :)
								calc
							fi 
						done

						if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -lt 0 ]]; then
							echo "so bloqueando o trafego de redirecionamento para essa celula...."
						fi
						#done
					fi
					rsu=rsu1
					x=$(hostapd_cli -i rsu1-wlan1 all_sta | grep :)
					calc 
				done
			fi
		fi
	done

	# 	# 	#se consegue ao menos atender as aplicacoes B
	# 	# 	if [[ $b -lt $up ]]; then

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

		# 	if [[ $i = "rsu2" ]]; then
		# 		#statements
		# 		# if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -ge $(cat saldo.txt | grep $i | cut -d'-' -f2) ]]; then
		# 		if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -ge 0 ]]; then
		# 			#statements
		# 			echo -e "\n RSU2 congestionada. Redireciona para RSU1"
		# 		# elif [[ $(cat saldo.txt | grep rsu3 | cut -d' ' -f2) -ge $(cat saldo.txt | grep $i | cut -d'-' -f2) ]]; then
		# 		if [[ $(cat saldo.txt | grep rsu3 | cut -d' ' -f2) -ge 0 ]]; then
		# 				#statements
		# 				echo -e "\n RSU2 congestionada. Redireciona para RSU3"
		# 		else
		# 			echo -e "\n RSU2 congestionada. RSUs 1 e 3 ocupadas. Nao tem jeito"
		# 		fi
		# 	fi
		# fi

	# done

	sleep $t
done


#Visto que o controlador local efetivamente controla no máximo os switchwes diretamente conectados, sendo os de upload e os das RSUs vizinhas, na implementação esse controle
#foi implementado através de código executando instruções com a ferramenta ovs-ofctl localmente nos openvswitches

#De tempos em tempos consulta a base de dados para o enforcement das politicas. Não haverá comunicação direta com o controlador central

#enquanto os switches locais sao controlados apenas pelos lc o de backbone e por todo mundo  so o de upload

#quando estiver redirecionando um tráfego, o controlador tem que contabilizar esse tráfego do veiculo que não está em ua RAN como consumindo o backbone
