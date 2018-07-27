import subprocess
import time

def print_debug(staA, staAt, staB, staBt):
	print "staA %d %s" % (staAt, staA)
	print "staB %d %s" % (staBt, staB)
	
while True:
	stasAP1  =  int(subprocess.check_output("sudo  hostapd_cli  -i  ap1-wlan1  all_sta  | grep aid | wc -l", shell=True).splitlines()[0])
	print stasAP1
	
	stasAP2  =  int(subprocess.check_output("sudo  hostapd_cli  -i  ap2-wlan1  all_sta  | grep aid | wc -l", shell=True).splitlines()[0])
	print stasAP2
	
	stasAP3  =  int(subprocess.check_output("sudo  hostapd_cli  -i  ap3-wlan1  all_sta  | grep aid | wc -l", shell=True).splitlines()[0])
	print stasAP3
	
	if stasAP1 == 2:
		print "\n\n\n===========AP 1 desbalanceado============\n"
		staA = subprocess.check_output("sudo hostapd_cli  -i ap1-wlan1 all_sta | grep : | head -1", shell=True).splitlines()[0]
		staB = subprocess.check_output("sudo hostapd_cli  -i ap1-wlan1 all_sta | grep : | tail -1", shell=True).splitlines()[0]
		staAt  =  int(subprocess.check_output("sudo  hostapd_cli  -i  ap1-wlan1  sta  "+ staA + "| grep conn | cut -d= -f2", shell=True).splitlines()[0])
		staBt  =  int(subprocess.check_output("sudo  hostapd_cli  -i  ap1-wlan1  sta  "+ staB + "| grep conn | cut -d= -f2", shell=True).splitlines()[0])
		print_debug(staA,staAt, staB, staBt)
		
		if staAt >= staBt:
			print "\nDisassociando %s" %staB
			print "\nTempo de Associacao %d\n" %staBt
			subprocess.call("sudo  hostapd_cli  -i  ap1-wlan1  disassociate  "+  staB, shell=True)
		else:
			print "\nDisassociando %s" %staA
			print "\nTempo de Associacao %d\n" %staAt
			subprocess.call("sudo  hostapd_cli  -i  ap1-wlan1  disassociate  "+  staA, shell=True)
		
		print "\n========Aguardando confirmar desassociacao...========\n"
		subprocess.call(" sudo ovs-ofctl del-flows s1", shell=True)
		
		while stasAP1 == 2:
			stasAP1  =  int(subprocess.check_output("sudo  hostapd_cli  -i  ap1-wlan1 all_sta | grep aid | wc -l", shell=True).splitlines()[0])
			time.sleep(1)
			
	if stasAP2 == 2:
		print "\n\n\n===========AP 2 desbalanceado============\n"
		staA = subprocess.check_output("sudo hostapd_cli  -i ap2-wlan1 all_sta | grep : | head -1", shell=True).splitlines()[0]
		staB = subprocess.check_output("sudo hostapd_cli  -i ap2-wlan1 all_sta | grep : | tail -1", shell=True).splitlines()[0]
		staAt  =  int(subprocess.check_output("sudo  hostapd_cli  -i  ap2-wlan1  sta  "+ staA + "| grep conn | cut -d= -f2", shell=True).splitlines()[0])
		staBt  =  int(subprocess.check_output("sudo  hostapd_cli  -i  ap2-wlan1  sta  "+ staB + "| grep conn | cut -d= -f2", shell=True).splitlines()[0])
		
		if staAt >= staBt:
			print "\nDisassociando %s" %staB
			print "\nTempo de Associacao %d\n" %staBt
			subprocess.call("sudo  hostapd_cli  -i  ap2-wlan1  disassociate  "+  staB, shell=True)
		else:
			print "\nDisassociando %s" %staA
			print "\nTempo de Associacao %d\n" %staAt
			subprocess.call("sudo  hostapd_cli  -i  ap2-wlan1  disassociate  "+  staA, shell=True)
			
		print "\n========Aguardando confirmar desassociacao...========\n"
		subprocess.call(" sudo ovs-ofctl del-flows s1", shell=True)
		
		while stasAP2 == 2:
			stasAP2  =  int(subprocess.check_output("sudo  hostapd_cli  -i  ap2-wlan1 all_sta | grep aid | wc -l", shell=True).splitlines()[0])
			
	if stasAP3 == 2:
		print "\n\n\n===========AP 3 desbalanceado============\n"
		staA = subprocess.check_output("sudo hostapd_cli  -i ap3-wlan1 all_sta | grep : | head -1", shell=True).splitlines()[0]
		staB = subprocess.check_output("sudo hostapd_cli  -i ap3-wlan1 all_sta | grep : | tail -1", shell=True).splitlines()[0]
		staAt  =  int(subprocess.check_output("sudo  hostapd_cli  -i  ap3-wlan1  sta  "+ staA + "| grep conn | cut -d= -f2", shell=True).splitlines()[0])
		staBt  =  int(subprocess.check_output("sudo  hostapd_cli  -i  ap3-wlan1  sta  "+ staB + "| grep conn | cut -d= -f2", shell=True).splitlines()[0])
		
		if staAt >= staBt:
			print "\nDisassociando %s" %staB
			print "\nTempo de Associacao %d\n" %staBt
			subprocess.call("sudo  hostapd_cli  -i  ap3-wlan1  disassociate  "+  staB, shell=True)
		else:
			print "\nDisassociando %s" %staA
			print "\nTempo de Associacao %d\n" %staAt
			subprocess.call("sudo  hostapd_cli  -i  ap3-wlan1  disassociate  "+  staA, shell=True)
			
		print "\n========Aguardando confirmar desassociacao...========\n"
		subprocess.call(" sudo ovs-ofctl del-flows s1", shell=True)
		
		while stasAP3 == 2:
			stasAP3  =  int(subprocess.check_output("sudo  hostapd_cli  -i  ap3-wlan1 all_sta | grep aid | wc -l", shell=True).splitlines()[0])
			
	time.sleep(2)