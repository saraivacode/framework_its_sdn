import subprocess
import time
conexao = subprocess.check_output("iw dev sta1-wlan0 link", shell=True)
flag = 1
while True:
	if flag == 1 and conexao == 'Not connected.\n':
		print "\n\nNao Conectado\n\n"
		subprocess.call("iw dev sta1-wlan0 connect ap1-ssid", shell=True)
		time.sleep(2)
		conexao = subprocess.check_output("iw dev sta1-wlan0 link", shell=True)
		flag = 2
		print "\n\nConectado no AP1\n\n"
	elif flag == 2 and conexao == 'Not connected.\n':
		print "\n\nNao Conectado\n\n"
		subprocess.call("iw dev sta1-wlan0 connect ap2-ssid", shell=True)
		time.sleep(2)
		conexao = subprocess.check_output("iw dev sta1-wlan0 link", shell=True)
		flag = 3
		print "\n\nConectado no AP2\n\n"
	elif flag == 3 and conexao == 'Not connected.\n':
		print "\n\nNao Conectado\n\n"
		subprocess.call("iw dev sta1-wlan0 connect ap3-ssid", shell=True)
		time.sleep(2)
		conexao = subprocess.check_output("iw dev sta1-wlan0 link", shell=True)
		flag =1
		print "\n\nConectado no AP3\n\n"
	else:
		time.sleep(1)
		conexao = subprocess.check_output("iw dev sta1-wlan0 link", shell=True)