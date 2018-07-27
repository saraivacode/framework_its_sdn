#!/bin/bash

#Define e aplica filas nos switches e respectivas portas
echo -e "\n Configurando filas"

#zera arquyivo para armazenamento de informações locais
rm -f temp2.txt

#Coleta os DPIDs dos switchs nas regiões de interesse com respectivas interfaces para aplicar filas e salva em temp2.txt
mysql -u root -pwifi -e "select dpid,iface_updtip from rsu where Region IN (select region from appkpi)" framework 2> /dev/null | grep '-' |
while read i;
do
	echo $i >> temp2.txt
done

#variavel de controle
t2=0

#Identifica DPIDs
b2=$(cat temp2.txt | awk -F' ' '{print $1}')


#Para cada DPID
for i in $b2;
do
	#incrementa variavel de controle
	t2=$(echo $t2+1 | bc)

	#salva emn x2 os valores de DPID e em y2 os valores de inteferface, para montar as expressões REST
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
	done)

	# define as taxas minimas a serem aplicadas para cada fila. Ex {"min_rate": "500000"}
	h=$(for i in $x; do echo {\"min_rate\": "\"$(echo $i)\""},; done | paste -s | cut -d',' -f1,2,3)

	#define comando final com max_rate fixos (melhorar/ajustar)
	j=$(echo curl -X POST -d "'{\"port_name\": \"$y2\", \"type\": \"linux-htb\", \"max_rate\": \"8300000\", \"queues\": [{\"max_rate\": \"1000000\"}, $(echo $h)]}'" http://localhost:8080/qos/queue/000000000000000$x2)
	
	#Envia comando para o controlador, contendo as filas e as referencias de DPID (switch) e porta
	# /bin/sh -c "$j"

	echo $j
done

echo -e "\n Configurando Qos"

# zera variavel de controle
t2=0

#Para cada DPID
for i in $b2;
do
	#incrementa variavel de controle
	t2=$(echo $t2+1 | bc)

	#salva emn x2 os valores de DPID
	x2=$(cat temp2.txt | awk -F' ' '{print $1}' | cut -d$'\n' -f$t2)

	#zera arquivo para armazenamento de informações locais
	rm -f temp.txt

	#busca na base as informações de endereço IP e porta dos servidores onde estão as aplicações e salva localmente em temp.txt
	mysql -u root -pwifi -e "select infrastructure.ip, appkpi.port from appkpi inner join infrastructure on appkpi.id = infrastructure.app;" framework 2> /dev/null | grep '\.' |
	while read i;
	do
		echo $i >> temp.txt
	done

	#variavel de controle interna
	t=0

	# Armazena em b os valores de endereços IP
	b=$(cat temp.txt | awk -F' ' '{print $1}')


	#Para cada endereço Ip de servidor de aplicação
	for i in $b;
	do
		#incrementa variável de controle
		t=$(echo $t+1 | bc)

		#Armazena o endereço IP em x e a porta em y
		x=$(cat temp.txt | awk -F' ' '{print $1}' | cut -d$'\n' -f$t)
		y=$(cat temp.txt | awk -F' ' '{print $2}' | cut -d$'\n' -f$t)

		#Monta e envia o comando associando o tráfego referente ao IP do servidor e a porta, à respectiva fila e em todos os DPIDs
		echo curl -X POST -d '{"match": {"nw_dst": "'$x'", "nw_proto": "UDP", "tp_dst": "'$y'"}, "actions":{"queue": "'$t'"}}' http://localhost:8080/qos/rules/000000000000000$x2

	done
done


echo -e "\n finalizado"


# Falta definir como preencher o max_rate (com o limite de upload da RSU?, como é acionado para fazer o recalculo diante de modificações na topologia.
#fica verificando de tempos em tempos a base de dados ou o script é executado a partir das mudanças? recalcula tudo ou só a diferença?
#como identificar a diferença??? (com base no id da aplicação passada como parâmetro!)