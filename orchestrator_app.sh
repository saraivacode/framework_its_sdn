#! /bin/bash

#Funções:

	# configura nova aplicação atualizando appkpi(`application`, `e2e_latency`, `reliability`, `data_rate`, `protocol`, `port`), infrastructure (`ip`, `app`)
	# and vehicle (`mac`, `app_id`, `region`), junto com flag de criação e pós atualização no banco notifica(??como??) controlador central -> chama script
	# informando criação de nova aplicação. Pensar na solução para MEC com delay abaixo de limiar (base de dados com MEC server?? - se são criados sob demanda fica estranho)


	#cadastrar novos veiculos e relacionar a aplicações, ou ainda deletar veiculos relacionados a aplicações. Atualizar tabela vehicle (`mac`, `app_id`, `region`)

	#implantação de nova aplicação

	# example (new app): ./mininet-wifi/scripts/orchestrator_app.sh 0 "teste" 1000 0.001 1500000 "TCP" 8054 "200.0.10.5"
	# example (update): ./mininet-wifi/scripts/orchestrator_app.sh 1 5 e2e_latency=2000 reliability=0.0001 data_rate=500000 protocol=\"UDP\" port=5014
	# example (update vehi add): ./mininet-wifi/scripts/orchestrator_app.sh 2 5 1 "00:00:00:00:00:03"
	# example (update vehi del): ./mininet-wifi/scripts/orchestrator_app.sh 2 5 1 "00:00:00:00:00:03" x


	flag=$1

	if [ "$flag" -eq "0" ]; then

		echo "Trata-se da implantação de nova aplicação "
			
		application=$2
		e2e_latency=$3
		reliability=$4
		data_rate=$5
		protocol=$6
		port=$7
		ip=$8

		mysql -u root -pwifi -e "insert into appkpi (id, application, e2e_latency, reliability, data_rate, protocol, port) values (NULL, \"$application\", $e2e_latency, $reliability, $data_rate, \"$protocol\", $port)" framework 2> /dev/null;

		id=$(mysql -u root -pwifi -e "select id from appkpi" framework 2> /dev/null | tail -1)

		mysql -u root -pwifi -e "insert into infrastructure (ip, app) values (\"$ip\", $id)" framework 2> /dev/null;

		# /bin/sh -c "$j"

		# ./mininet-wifi/scripts/central_controller.sh $flag $id &

	else
		
		if [[ "$flag" -eq "1" ]]; then

			echo "Trata-se de atualização da aplicação"

			id=$2

			i=3

			while [ $i -le $# ]; do
				
				if [[ $i -eq 3 ]]; then
					a=$(echo $3 | cut -d'=' -f1); b=$(echo $3 | cut -d'=' -f2); echo $a $b
					mysql -u root -pwifi -e "UPDATE appkpi SET $a = $b where id = $id" framework 2> /dev/null
				fi
				
				if [[ $i -eq 4 ]]; then
					a=$(echo $4 | cut -d'=' -f1); b=$(echo $4 | cut -d'=' -f2); echo $a $b
					mysql -u root -pwifi -e "UPDATE appkpi SET $a = $b where id = $id" framework 2> /dev/null
				fi

				if [[ $i -eq 5 ]]; then
					a=$(echo $5 | cut -d'=' -f1); b=$(echo $5 | cut -d'=' -f2); echo $a $b
					mysql -u root -pwifi -e "UPDATE appkpi SET $a = $b where id = $id" framework 2> /dev/null
				fi

				if [[ $i -eq 6 ]]; then
					a=$(echo $6 | cut -d'=' -f1); b=$(echo $6 | cut -d'=' -f2); echo $a $b
					mysql -u root -pwifi -e "UPDATE appkpi SET $a = $b where id = $id" framework 2> /dev/null
				fi

				if [[ $i -eq 7 ]]; then
					a=$(echo $7 | cut -d'=' -f1); b=$(echo $7 | cut -d'=' -f2); echo $a $b
					mysql -u root -pwifi -e "UPDATE appkpi SET $a = $b where id = $id" framework 2> /dev/null
				fi

				i=$( echo $i+1 | bc)

			done

			# ./mininet-wifi/scripts/central_controller.sh $flag $id &

		else

			if [[ "$flag" -eq "2" ]]; then

				echo "Atualiza veiculos"

				id=$2
				reg=$3
				mac=$4

				if [[ $5 == "x" ]]; then


					echo "deletar!"

					mysql -u root -pwifi -e "delete from vehicle where app_id = $id and mac = \"$mac\"" framework 

				else

					echo "inserir!"

					mysql -u root -pwifi -e "insert into vehicle (app_id, region, mac) values ($id, $reg, \"$mac\")" framework 
				fi

			else

				echo "invalid option"

			fi

		fi
	fi