#!/bin/bash

#define capacidade dos links de upload em mbps
up=5000000

#Define a periodicidade em segundos, na qual os controladores verificam o status da rede local
t=5
t2=10

appb_bw=500000
appc_bw=1000000

#Funcao que calcula saldo
function calc {
	#se tem veiculo na RAN
	if [[ $(echo $x | wc -w) -gt 0 ]]; then
		#calcula consumo com base dos MACs dos veiculos na RAN
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
	else
		y=0
		b=0
		c=0
	fi	

	#Verifica se existem fluxos cadastrados cuja RSUS em análise é destino (para debitar do saldo)
	dec=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where rsu_dest= '"$rsu_calc"' " framework 2> /dev/null | tail -1)
	#Verifica se esxistem fluxos cadastrados cuja RSUS em análise é origem (para incrementar do saldo)
	inc=$(mysql -u root -pwifi -e "select sum(bw_value) from redirect where rsu_o= '"$rsu_calc"' " framework 2> /dev/null | tail -1)
	#quando o resultado das funções anteriores é nulo transforma em 0 para efetuar os calculos posteriores
	if [ $inc = "NULL" ]; then
		inc=0
	fi

	if [ $dec = "NULL" ]; then
		dec=0
	fi					
	#Calcula o saldo da RSU em análise
	sd=$(echo $up-$y-$dec+$inc|bc)
	# echo -e "\n rsu: " $rsu_calc " dec: " $dec " inc: " $inc " sd: " $sd "y: " $y
	#zera arquivo de saldos que será utilizado como referência
	#Salva saldo calculado em arquivo temporario de controle, para uso nos demais algoritmos
	#echo $(echo $j | cut -d'-' -f1) $sd >> saldo.txt
	cat saldo.txt | grep -v $rsu_calc > temp.tmp
	echo $rsu_calc $sd >> temp.tmp
	rm saldo.txt
	mv temp.tmp saldo.txt
	# echo "saldo"
	# cat saldo.txt
}

function limpeza {
	#identifica MACs em redirecionamento cuja rsu local seja origem
	mac_rec=$(mysql -u root -pwifi -e "select mac from redirect where rsu_o= '"$rsu"' " framework 2> /dev/null | grep -v mac)
	#Verifica se esses MACs na base ainda não estão mais na RAN local e os apaga da tabela (desfazendo as configuracoes relacionadas - ex. flows) em caso negativo
	for m in $mac_rec;
	do
		if [[ $(hostapd_cli -i $j all_sta | grep $m -c) -eq 0 ]]; then
			#verifica rsu de destino dos redirecionamentos
			dst=$(mysql -u root -pwifi -e "select rsu_dest from redirect where mac  = \"$m\" and rsu_o = \"$rsu\"" framework 2> /dev/null | tail -1)
			echo -e "\n Apagando MAC indevido " $m" em " $rsu
			mysql -u root -pwifi -e "delete from redirect where mac  = \"$m\" and rsu_o = \"$rsu\"" framework 2> /dev/null
			#Apaga os flows na rsu de origem
			ovs-ofctl del-flows $rsu cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$m -O Openflow13
			ovs-ofctl del-flows $rsu cookie=0x$(echo $rsu | cut -d'u' -f2)5/-1,dl_src=$m -O Openflow13
			#Apaga os flows no switch de backbone
			ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$m -O Openflow13
			ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$m -O Openflow13
			#Se trafego nao foi bloqueado, apaga fluxos na rsu de destino
			if [[ $dst != "x" ]]; then
				ovs-ofctl del-flows $dst cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$m -O Openflow13
				ovs-ofctl del-flows $dst cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$m -O Openflow13
			fi
		fi
	done
}

#inicio do programa
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
		limpeza
		#inicializa valores de saldo para celulas vazias
		sd=$up
		y=0
		b=0
		c=0
		inc=0
		dec=0
		#Inicializa arquivo de saldos
		cat saldo.txt | grep -v $rsu > temp.tmp
		echo $rsu $up >> temp.tmp
		rm saldo.txt
		mv temp.tmp saldo.txt
		#verifica se existe registro de redirecionamento relacionado a RAN em analise (motivo para calcular saldo)
		r=$(mysql -u root -pwifi -e "select * from redirect" framework 2> /dev/null | grep -c $rsu)
		if [ $r = "NULL" ]; then
			r=0
		fi
		rsu_calc=$rsu
		#se existem veiculos ou registro de redirecionamento para RAN, calcula saldo
		if [[ $(echo $x | wc -w) -gt 0 ]] || [[ $r -gt 0 ]]; then
			calc			
		fi
		#Imprime resultado dos calculos de saldo na tela
		echo -e $(date) $rsu " tem ocupado " $(echo $y|bc)   " ($b com B e $c com C)." " dec: " $dec " inc: " $inc " sd: " $sd ". " $(echo $x| wc -w) "veiculos. r " $r
	done
	echo -e "\n =========================================//==============================================================="
	##################################Parte 2 do codigo, que lida com a parte dos redirecionamentos#####################################
	#para cada rsu no arquivo de saldos
	for rsu in $(cat saldo.txt | cut -d' ' -f1);
	do

		if [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; then
			echo $rsu congestionada. Aguardando $t2 segundos para confirmacao
			sleep $t2
			echo recalculando saldos...
			for j in $(ifconfig | grep wlan | cut -d' ' -f1);
			do
				rsu_calc=$(echo $j | cut -d'-' -f1)
				x=$(hostapd_cli -i $j all_sta | grep :)
				calc
				echo -e $(date) $rsu_calc " tem ocupado " $(echo $y|bc)   " ($b com B e $c com C)." " dec: " $dec " inc: " $inc " sd: " $sd ". " $(echo $x| wc -w) "veiculos. r " $r
			done
			echo -e "\n =========================================//==============================================================="
		fi

		#se o saldo for menor que zero (precisa de acao). Se for a rsu1 ou rsu3 (que só tem a rsu2 como vizinhos)
		if [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]] && [[ $rsu != "rsu2" ]]; then
			#enquanto o saldo for negativo na RSU1 ou RSU3
			while [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; do
				#identifica os MACs na RSU1 ou RSU3
				mac_rsu1=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)

				#inicializa arquivos de controle das aplicacoes
				rm -f appc.txt
				rm -f appb.txt

				#identifica os MACs na rsu1 ou rsu3 e saldo nos respectivos arquivos se já não foi redirecionado/bloqueado
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
				#Se vizinho (rsu2 aceita aplicação C e existe MAC associado a aplicação C - escalabilidade
				if [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $appc_bw ]] && [[ $(cat appc.txt | wc -l) -gt 0 ]]; then
					for i in $(cat appc.txt);
					do
						#Enquanto tiver saldo no vizinho para suportar alguma aplicação C e rsu local estiver com saldo negativo
						if [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $appc_bw ]] && [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]] ; then
							#Imprime na tela mensagem de controle
							echo -e "\n $rsu congestionada. RSU2 suporta ao menos uma aplicação C. Aplicacoes C serao redirecionadas ate haver saldo."
							echo $i " esta associado a aplicacao C"
							echo "redireciona " $i " de $rsu para rsu2"
							#Redireciona tráfego de aplicação C, da RSU1 ou RSU3 para RSU2
							#verifica se rsu2 (vizinha) consegue ao menos suportar uma aplicação C (primeiras a serem redirecionadas, em função dos requisitos)
							#Para cada mac (veiculo) na rsu1, verifica se está associado a aplicação C
							#insere flows na rsu origem de maior prioridade
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=2" -O Openflow13
							#ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x10, dl_dst=$i actions=1" -O Openflow13
							#Insere flows na RSU de redirecionamento (ajustar, a depender da origem)
							if [[ $rsu = "rsu1" ]]; then
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=4" -O Openflow13
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4,dl_dst=$i, udp,tp_src=5004 actions=2" -O Openflow13
							else
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=3,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=4" -O Openflow13
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4,dl_dst=$i, udp,tp_src=5004 actions=3" -O Openflow13
							fi
							#Insere flows de maior prioridade no backbone
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1,dl_dst=$i, udp,tp_src=5004 actions=3" -O Openflow13
							#Deleta flows no backbone para evitar confusao (reativar em caso de mobilidade automatica)
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
							#cadastra na banco
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"rsu2\", $appc_bw)" framework 2> /dev/null
							#para calcular o saldo na rsu de destino (rsu2) e na de origem
							rsu_calc=rsu2
							x=$(hostapd_cli -i rsu2-wlan1 all_sta | grep :)
							calc 
							rsu_calc=$rsu
							x=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
							calc
						fi
					done
				elif [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $appb_bw ]] && [[ $(cat appb.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appb.txt);
					do
						#se a RSU1 continua congestionada e o vizinho não suporta aplicação C, verifica se suporta B
						if [[ $(cat saldo.txt | grep rsu2 | cut -d' ' -f2) -ge $appb_bw ]] && [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; then
							#mensagem de controle
							echo -e "\n $rsu continua congestionada. RSU2 suporta ao menos uma aplicacao B. Aplicacoes B serao redirecionadas ate haver saldo"
							echo $i " esta associado a aplicacao B"
							echo "redireciona " $i " de $rsu para rsu2"
							#Redireciona tráfego de aplicação B, da RSU1 para RSU2
							#insere flows na rsu origem de maior prioridade
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.3, udp,tp_dst=5003 actions=2" -O Openflow13
							#ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x10, dl_dst=$i actions=1" -O Openflow13
							#Insere flows na RSU de redirecionamento (ajustar, a depender da origem)
							if [[ $rsu = "rsu1" ]]; then
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=2, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=4" -O Openflow13
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4, dl_dst=$i, udp,tp_src=5003 actions=2" -O Openflow13
							else
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=4" -O Openflow13
								ovs-ofctl add-flow rsu2 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4, dl_dst=$i, udp, tp_src=5003 actions=3" -O Openflow13
							fi
							#Insere flows de maior prioridade no backbone
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_dst=$i, udp, tp_src=5003 actions=3" -O Openflow13
							#Deleta flows no backbone para evitar confusao (reativar em caso de mobilidade automatica)
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
							#cadastra na banco
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"rsu2\", $appb_bw)" framework 2> /dev/null
							#para calcular o saldo na rsu de destino (rsu2) e na de origem
							rsu_calc=rsu2
							x=$(hostapd_cli -i rsu2-wlan1 all_sta | grep :)
							calc 
							rsu_calc=$rsu
							x=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
							calc
						fi
					done
				elif [[ $(cat appc.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appc.txt);
					do				
						if [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; then
							echo -e "\n $rsu continua congestionada. RSU2 esta sem saldo disponivel. Aplicacao C sera bloqueada ate haver saldo."
							echo $i " esta associado a aplicacao C e será bloqueada"
							echo "bloqueando " $i " em $rsu..."
							#bloqueia trafego
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=drop" -O Openflow13
							#cadastra na banco
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"x\", $appc_bw)" framework 2> /dev/null
							#envia flows
							rsu_calc=$rsu
							x=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
							calc 
						fi
					done
				#Verifica possibilidade de bloqueio dos redirecionamentos de aplicacao C redirecionadas para nao ter que bloquear B
				elif [[ $(mysql -u root -pwifi -e "select mac from redirect where rsu_o='"$rsu"' and bw_value=$appc_bw and rsu_dest!='"x"'" framework 2> /dev/null | grep -v mac | tail -1 | grep : -c ) -gt 0 ]]; then
					echo -e "\n $rsu continua congestionada. RSU2 esta sem saldo disponivel. Aplicacoes C direcionadas serao bloqueadas ate haver saldo no vizinho."
					#identifica aplicação C anteriormente redirecionada
					i=$(mysql -u root -pwifi -e "select mac from redirect where rsu_o='"$rsu"' and bw_value=$appc_bw" framework 2> /dev/null | grep -v mac | tail -1)
					echo "Aplicacao C em $i estava redirecionada e sera bloqueada."
					#Bloqueia aplicacao C na fonte
					ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=drop" -O Openflow13
					#Apaga redirecionamentos da aplicacao C
					ovs-ofctl del-flows $rsu cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,udp,tp_dst=5004 -O Openflow13
					ovs-ofctl del-flows rsu2 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$i,udp,tp_src=5004 -O Openflow13
					ovs-ofctl del-flows rsu2 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,udp,tp_dst=5004 -O Openflow13
					ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$i,udp,tp_src=5004 -O Openflow13
					ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,udp,tp_dst=5004 -O Openflow13
					#Atualiza tabela de redirecionamento com a informacao de bloqueio
					mysql -u root -pwifi -e "update redirect set rsu_dest=\"x\" where mac=\"$i\" and bw_value=$appc_bw" framework 2> /dev/null
					#recalcula saldo no vizinho
					rsu_calc=rsu2
					x=$(hostapd_cli -i rsu2-wlan1 all_sta | grep :)
					calc 
				#último caso, bloqueia aplicações B
				elif [[ $(cat appb.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appb.txt);
					do
						if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -lt 0 ]]; then
							echo -e "\n $rsu continua congestionada. RSU2 esta sem saldo disponivel. Sem acoes em aplicacoes C. Aplicacoes B serao bloqueadas ate haver saldo."
							echo $i " esta associado a aplicacao B e será bloqueada"
							echo "bloqueando " $i " em $rsu..."
							#bloqueia trafego (limitacao desbloquear caso a ran fique livre)
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1,dl_src=$i, nw_dst=200.0.10.3, udp,tp_dst=5003 actions=drop" -O Openflow13
							#cadastra na banco
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"x\", $appb_bw)" framework 2> /dev/null
							#recalcula saldo
							rsu_calc=$rsu
							x=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
							calc
						fi 
					done
				else
					echo "so bloqueando o trafego de redirecionamento para essa celula..."
				fi
				rsu_calc=$rsu
				x=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
				calc 
			done
		#se for o caso da RSU2
		elif [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]] && [[ $rsu = "rsu2" ]]; then
			#enquanto o saldo for negativo na RSU2
			while [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; do
				#identifica os MACs na RSU2
				mac_rsu1=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
				#Se MACS estao associados a aplicasoes B ou C e nao foram redirecionados ou bloqueados, salva nos respectivos arquivos

				#inicializa arquivos de controle das aplicacoes
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

				 # echo "appb.txt"
				 # cat appb.txt
				 # echo "appc.txt"
				 # cat appc.txt
				#Para vizinho rsu1, verifica se aceita aplicação C e existe MAC associado a aplicação C
				if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -ge $appc_bw ]] && [[ $(cat appc.txt | wc -l) -gt 0 ]]; then
					for i in $(cat appc.txt);
					do
						#Enquanto tiver saldo no vizinho para suportar alguma aplicação C e rsu local estiver com saldo negativo
						if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -ge $appc_bw ]] && [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]] ; then
							#Imprime na tela mensagem de controle
							echo -e "\n $rsu congestionada. RSU1 suporta ao menos uma aplicação C. Aplicacoes C serao redirecionadas ate haver saldo."
							echo $i " esta associado a aplicacao C"
							echo "redireciona " $i " de $rsu para rsu1"
							#Redireciona tráfego de aplicação C, da RSU2 para RSU1
							#insere flows na rsu origem de maior prioridade
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=2" -O Openflow13
							#ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x10, dl_dst=$i actions=1" -O Openflow13
							#Insere flows na RSU de redirecionamento
							ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=3" -O Openflow13
							ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3,dl_dst=$i, udp,tp_src=5004 actions=2" -O Openflow13
							#Insere flows de maior prioridade no backbone
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=2,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1,dl_dst=$i, udp,tp_src=5004 actions=2" -O Openflow13
							#Deleta flows no backbone para evitar confusao (reativar em caso de mobilidade automatica)
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
							#cadastra na banco
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"rsu1\", $appc_bw)" framework 2> /dev/null
							#para calcular o saldo na rsu1
							rsu_calc=rsu1
							x=$(hostapd_cli -i rsu1-wlan1 all_sta | grep :)
							calc 
							rsu_calc=$rsu
							x=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
							calc
						fi
					done
					#Para vizinho rsu3, verifica se aceita aplicação C e existe MAC associado a aplicação C
				elif [[ $(cat saldo.txt | grep rsu3 | cut -d' ' -f2) -ge $appc_bw ]] && [[ $(cat appc.txt | wc -l) -gt 0 ]]; then
					for i in $(cat appc.txt);
					do
						#Enquanto tiver saldo no vizinho para suportar alguma aplicação C e rsu local estiver com saldo negativo
						if [[ $(cat saldo.txt | grep rsu3 | cut -d' ' -f2) -ge $appc_bw ]] && [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]] ; then
							#Imprime na tela mensagem de controle
							echo -e "\n $rsu congestionada. RSU3 suporta ao menos uma aplicação C. Aplicacoes C serao redirecionadas ate haver saldo."
							echo $i " esta associado a aplicacao C"
							echo "redireciona " $i " de $rsu para rsu3"
							#Redireciona tráfego de aplicação C, da RSU2 para RSU3
							#insere flows na rsu origem de maior prioridade
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=3" -O Openflow13
							#ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x10, dl_dst=$i actions=1" -O Openflow13
							#Insere flows na RSU de redirecionamento
							ovs-ofctl add-flow rsu3 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=3" -O Openflow13
							ovs-ofctl add-flow rsu3 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3,dl_dst=$i, udp,tp_src=5004 actions=2" -O Openflow13
							#Insere flows de maior prioridade no backbone
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4,dl_src=$i, nw_dst=200.0.10.4, udp,tp_dst=5004 actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1,dl_dst=$i, udp,tp_src=5004 actions=4" -O Openflow13
							#Deleta flows no backbone para evitar confusao (reativar em caso de mobilidade automatica)
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
							#cadastra na banco
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"rsu3\", $appc_bw)" framework 2> /dev/null
							#para calcular o saldo na rsu1
							rsu_calc=rsu3
							x=$(hostapd_cli -i rsu3-wlan1 all_sta | grep :)
							calc 
							rsu_calc=$rsu
							x=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
							calc
						fi
					done			
				#Se vizinhos (RSU1) tem saldo para ao menos uma aplicação B e existe aplicação B	
				elif [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -ge $appb_bw ]] && [[ $(cat appb.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appb.txt);
					do
						#se a RSU2 continua congestionada e o vizinho (rsu1) não suporta aplcação C, verifica se suporta B e redireciona
						if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -ge $appb_bw ]] && [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; then
							#mensagem de controle
							echo -e "\n $rsu continua congestionada. RSU1 suporta ao menos uma aplicacao B. Aplicacoes B serao redirecionadas ate haver saldo"
							echo $i " esta associado a aplicacao B"
							echo "redireciona " $i " de $rsu para rsu2"
							#Redireciona tráfego de aplicação B, da RSU2 para RSU1
							#insere flows na rsu origem de maior prioridade
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=2" -O Openflow13
							#ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x10, dl_dst=$i actions=1" -O Openflow13
							#Insere flows na RSU de redirecionamento
							ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=3" -O Openflow13
							ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_dst=$i, udp, tp_src=5003 actions=2" -O Openflow13
							#Insere flows de maior prioridade no backbone
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=2, dl_src=$i, nw_dst=200.0.10.3, udp, tp_dst=5003 actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_dst=$i, udp, tp_src=5003 actions=2" -O Openflow13
							#Deleta flows no backbone para evitar confusao (reativar em caso de mobilidade automatica)
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
							#cadastra na banco
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"rsu1\", $appb_bw)" framework 2> /dev/null
							#Calcula saldos
							rsu_calc=rsu1
							x=$(hostapd_cli -i rsu1-wlan1 all_sta | grep :)
							calc 
							rsu_calc=$rsu
							x=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
							calc
						fi
					done
				#Se vizinhos (RSU3) tem saldo para ao menos uma aplicação B e existe aplicação B	
				elif [[ $(cat saldo.txt | grep rsu3 | cut -d' ' -f2) -ge $appb_bw ]] && [[ $(cat appb.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appb.txt);
					do
						#se a RSU2 continua congestionada e o vizinho (rsu3) não suporta aplcação C, verifica se suporta B e redireciona
						if [[ $(cat saldo.txt | grep rsu3 | cut -d' ' -f2) -ge $appb_bw ]] && [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; then
							#mensagem de controle
							echo -e "\n $rsu continua congestionada. RSU3 suporta ao menos uma aplicacao B. Aplicacoes B serao redirecionadas ate haver saldo"
							echo $i " esta associado a aplicacao B"
							echo "redireciona " $i " de $rsu para rsu3"
							#Redireciona tráfego de aplicação B, da RSU2 para RSU3
							#insere flows na rsu origem de maior prioridade
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_src=$i, nw_dst=200.0.10.3, udp,tp_dst=5003 actions=3" -O Openflow13
							#ovs-ofctl add-flow rsu1 "table=1, priority=2, cookie=0x10, dl_dst=$i actions=1" -O Openflow13
							#Insere flows na RSU de redirecionamento
							ovs-ofctl add-flow rsu3 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2) ,in_port=2, dl_src=$i, nw_dst=200.0.10.3, udp,tp_dst=5003 actions=3" -O Openflow13
							ovs-ofctl add-flow rsu3 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=3, dl_dst=$i, udp,tp_src=5003 actions=2" -O Openflow13
							#Insere flows de maior prioridade no backbone
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=4, dl_src=$i, nw_dst=200.0.10.3, udp,tp_dst=5003 actions=1" -O Openflow13
							ovs-ofctl add-flow sw1 "table=1, priority=2, cookie=0x1$(echo $rsu | cut -d'u' -f2), in_port=1, dl_dst=$i, udp,tp_src=5003 actions=4" -O Openflow13
							#Deleta flows no backbone para evitar confusao (reativar em caso de mobilidade automatica)
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=$i -O Openflow13
							# ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=$i -O Openflow13
							#cadastra na banco
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"rsu3\", $appb_bw)" framework 2> /dev/null
							#Calcula saldos
							rsu_calc=rsu3
							x=$(hostapd_cli -i rsu3-wlan1 all_sta | grep :)
							calc 
							rsu_calc=$rsu
							x=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
							calc
						fi
					done
				#Verifica a possibilidade de bloquear aplicações C
				elif [[ $(cat appc.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appc.txt);
					do				
						if [[ $(cat saldo.txt | grep $rsu | cut -d' ' -f2) -lt 0 ]]; then
							echo -e "\n $rsu continua congestionada. RSU1 esta sem saldo disponivel. Aplicacao C sera bloqueada ate haver saldo."
							echo $i " esta associado a aplicacao C e será bloqueada"
							echo "bloqueando " $i " em $rsu..."
							#bloqueia trafego
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.4, udp, tp_dst=5004 actions=drop" -O Openflow13
							#cadastra na banco
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"x\", $appc_bw)" framework 2> /dev/null
							#recalcula saldo
							rsu_calc=$rsu
							x=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
							calc 
						fi
					done
				#Verifica possibilidade de bloqueio dos redirecionamentos de aplicacao C redirecionadas para nao ter que bloquear B
				elif [[ $(mysql -u root -pwifi -e "select mac from redirect where rsu_o='"$rsu"' and bw_value=$appc_bw and rsu_dest!='"x"'" framework 2> /dev/null | grep -v mac | tail -1 | grep : -c ) -gt 0 ]]; then
					echo -e "\n $rsu continua congestionada. RSUs 1 e 3 estao sem saldo disponivel. Aplicacoes C direcionadas serao bloqueadas ate haver saldo no vizinho."
					#identifica aplicação C anteriormente redirecionada
					i=$(mysql -u root -pwifi -e "select mac from redirect where rsu_o='"$rsu"' and bw_value=$appc_bw and rsu_dest!='"x"'" framework 2> /dev/null | grep -v mac | tail -1)
					#identifica rsu de destino
					rsudst=$(mysql -u root -pwifi -e "select rsu_dest from redirect where rsu_o='"$rsu"' and mac='"$i"' and bw_value=$appc_bw" framework 2> /dev/null | grep -v dst | tail -1)

					echo "Aplicacao C em $i estava redirecionada para $rsudst e sera bloqueada."
					#Bloqueia aplicacao C na fonte
					ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1, dl_src=$i, nw_dst=200.0.10.4, udp, tp_dst=5004 actions=drop" -O Openflow13
					#Apaga redirecionamentos da aplicacao C
					ovs-ofctl del-flows $rsu cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,udp,tp_dst=5004 -O Openflow13
					ovs-ofctl del-flows $rsudst cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$i,udp,tp_src=5004 -O Openflow13
					ovs-ofctl del-flows $rsudst cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,udp,tp_dst=5004 -O Openflow13
					ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_dst=$i,udp,tp_src=5004 -O Openflow13
					ovs-ofctl del-flows sw1 cookie=0x1$(echo $rsu | cut -d'u' -f2)/-1,dl_src=$i,nw_dst=200.0.10.4,udp,tp_dst=5004 -O Openflow13
					#Atualiza tabela de redirecionamento com a informacao de bloqueio
					mysql -u root -pwifi -e "update redirect set rsu_dest=\"x\" where mac=\"$i\" and bw_value=$appc_bw" framework 2> /dev/null
					#recalcula saldo no vizinho
					rsu_calc=$rsudst
					x=$(hostapd_cli -i $rsudst-wlan1 all_sta | grep :)
					calc
				#último caso, bloqueia aplicações B
				elif [[ $(cat appb.txt | wc -l) -gt 0 ]]; then
					for i in $( cat appb.txt);
					do
						if [[ $(cat saldo.txt | grep rsu1 | cut -d' ' -f2) -lt 0 ]]; then
							echo -e "\n $rsu continua congestionada. RSUs 1 e 3 estao sem saldo disponivel. Sem acoes em aplicacoes C. Aplicacoes B serao bloqueadas ate haver saldo."
							echo $i " esta associado a aplicacao B e será bloqueada"
							echo "bloqueando " $i " em $rsu..."
							#bloqueia trafego (limitacao desbloquear caso a ran fique livre)
							ovs-ofctl add-flow $rsu "table=1, priority=2, cookie=0x$(echo $rsu | cut -d'u' -f2)5, in_port=1,dl_src=$i, nw_dst=200.0.10.3, udp,tp_dst=5003 actions=drop" -O Openflow13
							#cadastra na banco
							mysql -u root -pwifi -e "insert into redirect (mac, rsu_o, rsu_dest, bw_value) values (\"$i\", \"$rsu\", \"x\", $appb_bw)" framework 2> /dev/null
							#recalcula saldo
							rsu_calc=$rsu
							x=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
							calc
						fi 
					done
				else
					echo "so bloqueando o trafego de redirecionamento para essa celula...."
				fi
				rsu_calc=$rsu
				x=$(hostapd_cli -i $rsu-wlan1 all_sta | grep :)
				calc
			done		
		fi
	done
	sleep $t
done