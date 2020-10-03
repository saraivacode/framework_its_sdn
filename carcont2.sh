#!/bin/bash

int=$(ifconfig | grep wlan | cut -d' ' -f1) # busca interface
car=$(ifconfig | grep wlan | cut -d' ' -f1| cut -d'-' -f1 | sed 's/car//') # busca numero do carro
c0="0" #variavel de controle

echo $(date +%s) - "iniciando "  >> log_car$car\_s.txt #registra inicio da execucao do script

#Start tcpdump in each vehicle to capture data and analize afterwards
tcpdump -i car$car\-wlan0 --direction=out -tttttnnvS --immediate-mode -l > car$car\.txt &
#Save start data time for future analis
t=$(date +%s.%N)
echo tempo_ini $t > logcar$car\.txt #registra inicio da execucao do script novamente???


#while [[ $(iw dev $int link | grep SSID) == "" ]]; do
while (true); do
	if [[ $c0 != "1" ]]; then

		x=$(iw dev $int scan | grep SSID: | cut -d' ' -f2) # salva os SSIDs na area de cobertura do veiculo na variavel x 
		sleep 3
		echo $(date +%s) - "disponivel redes: " $x >> log_car$car\_s.txt

		if [[ $(iw dev $int link | grep SSID) == "" ]]; then # se o veiculo nao estiver conectado
			echo $(date +%s) - "sem conexao "  >> log_car$car\_s.txt
			
			if (( $car < 27)) && [[ $x == 'rsu3' ]]; then 
				echo $(date +%s) - "rsu3 para car " $car  >> log_car$car\_s.txt
				echo $(date +%s) - "desconectando de eventual conexao" >> log_car$car\_s.txt
				iw dev $int disconnect
				sleep 1
				echo $(date +%s) - "conectando na rsu3 " >> log_car$car\_s.txt
				iw dev $int connect rsu3
				sleep 3
				while [[ "$(iw dev $int link | grep -c SSID )" -eq 0 ]]; do
					echo $(date +%s) - "tentando novamente na rsu3 " >> log_car$car\_s.txt
					iw dev $int connect rsu3
					sleep 3
				done
				h=$(iw dev $int link | grep SSID)
				sleep 1

				echo $(date +%s) - "conectando na " $h >> log_car$car\_s.txt
				c0="1"
				echo $(date +%s) - "iniciando o ping " >> log_car$car\_s.txt
				#ping 200.0.10.4 -i 1 | while read line; do echo $(date +%s) - $line - $h>> ping$x\_teste$car\_s.txt; done &

				t=$(date +%s.%N)
				echo tempo_transm $t >> logcar$car\.txt

				ping 200.0.10.2 -i 0.2 -c 2500 | while read line; do echo $(date +%s) - $line >> okok$car\_s.txt; done &


			elif (( $car > 26 )) && (( $car < 38)) && [[ $x == 'rsu2' ]]; then
				echo $(date +%s) - "rsu2 para car " $car  >> log_car$car\_s.txt
				echo $(date +%s) - "desconectando de eventual conexao" >> log_car$car\_s.txt
				iw dev $int disconnect
				sleep 1
				echo $(date +%s) - "conectando na rsu2 " >> log_car$car\_s.txt
				iw dev $int connect rsu2
				sleep 3

				while [[ "$(iw dev $int link | grep -c SSID )" -eq 0 ]]; do
					echo $(date +%s) - "tentando novamente na rsu2 " >> log_car$car\_s.txt
					iw dev $int connect rsu2
					sleep 3
				done
				h=$(iw dev $int link | grep SSID)
				sleep 1

				echo $(date +%s) - "conectando na " $h >> log_car$car\_s.txt
				c0="1"
				echo $(date +%s) - "iniciando o ping " >> log_car$car\_s.txt
				#ping 200.0.10.4 -i 1 | while read line; do echo $(date +%s) - $line - $h >> ping$x\_teste$car\_s.txt; done &

				t=$(date +%s.%N)
				echo tempo_transm $t >> logcar$car\.txt

				ping 200.0.10.2 -i 0.2 -c 2500 | while read line; do echo $(date +%s) - $line >> okok$car\_s.txt; done &

			elif (( $car > 37)) && (( $car < 50)) && [[ $x == 'rsu1' ]]; then
				echo $(date +%s) - "rsu1 para car " $car  >> log_car$car\_s.txt
				echo $(date +%s) - "desconectando de eventual conexao" >> log_car$car\_s.txt
				iw dev $int disconnect
				sleep 1
				echo $(date +%s) - "conectando na rsu1 " >> log_car$car\_s.txt
				iw dev $int connect rsu1
				sleep 3

				while [[ "$(iw dev $int link | grep -c SSID )" -eq 0 ]]; do
					echo $(date +%s) - "tentando novamente na rsu1 " >> log_car$car\_s.txt
					iw dev $int connect rsu1
					sleep 3
				done
				h=$(iw dev $int link | grep SSID)
				sleep 1

				echo $(date +%s) - "conectado na " $h >> log_car$car\_s.txt
				c0="1"
				echo $(date +%s) - "iniciando o ping " >> log_car$car\_s.txt
				#ping 200.0.10.4 -i 1 | while read line; do echo $(date +%s) - $line - $h >> ping$x\_teste$car\_s.txt; done &

				t=$(date +%s.%N)
				echo tempo_transm $t >> logcar$car\.txt

				ping 200.0.10.2 -i 0.2 -c 2500 | while read line; do echo $(date +%s) - $line >> okok$car\_s.txt; done &
			else
				sleep 5
			fi
		else
			ssid=$(iw dev $int link | grep SSID)
			sleep 5
			echo $(date +%s) - "desconectando de " $ssid " conexao" >> log_car$car\_s.txt
			iw dev $int disconnect
			sleep 1
		fi
	fi
done




