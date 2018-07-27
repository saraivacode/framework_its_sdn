#!/usr/bin/python

"""
ITS Application Driven Vehicular Networks
Video clip available at: https://www.youtube.com/watch?v=.....
"""

import os
import time
import matplotlib.pyplot as plt

from mininet.log import setLogLevel
from mininet.node import RemoteController, OVSKernelSwitch
from mininet.wifi.node import OVSKernelAP
from mininet.wifi.net import Mininet_wifi
from mininet.wifi.cli import CLI_wifi
from mininet.link import TCLink

from mininet.term import makeTerm

def topology():

    ncars = 3

    "Create a network."
    net = Mininet_wifi(controller=None, autoStaticArp=True, switch=OVSKernelSwitch, accessPoint=OVSKernelAP)
    c1 = net.addController( 'c1', controller=RemoteController, ip='127.0.0.1', port=6633 )

    print("*** Creating nodes")
    cars = []
    stas = []
    for idx in range(0, ncars):
        cars.append(idx)
        stas.append(idx)

    #for idx in range(0, ncars):
    cars[0] = net.addCar('car0', wlans=1, range="40", ip='200.0.10.100/8', mac='00:00:00:00:00:01', mode='b', position='100,115,0')
    cars[1] = net.addCar('car1', wlans=1, range="40", ip='200.0.10.150/8', mac='00:00:00:00:00:02', mode='b', position='200,115,0')
    cars[2] = net.addCar('car2', wlans=1, range="40", ip='200.0.10.200/8', mac='00:00:00:00:00:03', mode='b', position='50,115,0')

    rsu1 = net.addAccessPoint('rsu1', ssid='rsu1', dpid='0000000000000006', mode='g', channel='11',range=40, position='75,140,0', protocols='OpenFlow13')
    rsu2 = net.addAccessPoint('rsu2', ssid='rsu2', dpid='0000000000000007', mode='g', channel='11', range=40, position='200,140,0', protocols='OpenFlow13')
    sw1 = net.addSwitch ('sw1', dpid='0000000000000008', protocols='OpenFlow13')
    sw2 = net.addSwitch ('sw2', dpid='0000000000000009', protocols='OpenFlow13')

    server_s = net.addHost ('server_s', ip='200.0.10.2/8')
    server_e = net.addHost ('server_e', ip='200.0.10.3/8')
    server_e2 = net.addHost ('server_e2', ip='200.0.10.4/8')
    
    server_s.plot(position='210,190,0')
    server_e.plot(position='210,220,0')
    server_e2.plot(position='210,240,0')

    sw1.plot(position='125,218,0')
    sw2.plot(position='170,218,0')

    print("*** Configuring Propagation Model")
    net.propagationModel(model="logDistance", exp=4.1)

    net.useIFB()

    print("*** Configuring wifi nodes")
    net.configureWifiNodes()

    print("*** Creating links")
    net.addLink(rsu1, sw1)
    net.addLink(rsu2, sw1)
    net.addLink(server_s, sw2)
    net.addLink(server_e, sw2)
    net.addLink(server_e2, sw2)
    link1 = net.addLink( sw1, sw2, cls=TCLink )

    print( "*** Configuring one intf with bandwidth of 9 Mb" )
    link1.intf1.config( bw=10, delay='10ms')

    'Plotting Graph'
    net.plotGraph(max_x=250, max_y=250)

    print("*** Starting network")
    net.build()
    c1.start()
    rsu1.start([c1])
    rsu2.start([c1])
    sw1.start([c1])
    sw2.start([c1])

    for sw in net.carsSW:
        sw.start([c1])

    os.system('ovs-vsctl --all destroy QoS; ovs-vsctl --all destroy Queue')

    os.system('ovs-vsctl set-manager ptcp:6632')

    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000006/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000007/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000008/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000009/ovsdb_addr')

    # print("*** Starting servers")
    # server_s.cmdPrint("iperf -s -u -i 1 -p 5002 > /dev/null &")
    # server_e.cmdPrint("iperf -s -u -i 1 -p 5003 > /dev/null &")
    # server_e2.cmdPrint("iperf -s -u -i 1 -p 5004 > /dev/null &")
    time.sleep(2)

    # cars[0].cmd('ulimit -u 500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000')
    # cars[1].cmd('ulimit -u 500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000')
    # cars[2].cmd('ulimit -u 500000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000000')

    # time.sleep(1)

    # timeout = 120


    server_s.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    server_e.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    server_e2.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')

    time.sleep(1)

    print("*** Car[0] connection 7.5Mbps")
    cars[0].cmdPrint("timeout 205 hping3 --udp -p 5002 -i u1400 -d 1470 200.0.10.2 -q &")
    time.sleep(2)

    cars[0].cmd('tcpdump udp port 5002 -i car0-wlan0 --direction=out -tttttnnvS > car.txt &')
    server_s.cmd('tcpdump udp port 5002 -i server_s-eth0 --direction=in -tttttnnvS > server.txt &')
    # cars[0].cmdPrint("ping 200.0.10.2 -i 1 -c %s  > ping.txt &", % timeout)
    cars[0].cmdPrint("ping 200.0.10.2 -i 1 -c 205  > ping.txt &")
    # makeTerm(cars[0], cmd="ping 200.0.10.2 -i 1")
    
    print("*** Deu certo!")

    time.sleep(105)

    print("*** Car[1] e car[2] iniciam em paralelo - 7.5Mbps cada")
    cars[1].cmdPrint("timeout 205 hping3 --udp -p 5003 -i u1400 -d 1470 200.0.10.3 -q &") 
    cars[2].cmdPrint("timeout 205 hping3 --udp -p 5004 -i u1400 -d 1470 200.0.10.4 -q &")

    time.sleep(100)

    print("*** Aplica QoS")
    os.system('curl -X POST -d \'{"port_name": "rsu2-eth2", "type": "linux-htb", "max_rate": "9000000", "queues": [{"max_rate": "1000000"}, {"min_rate": "6000000"}]}\' http://localhost:8080/qos/queue/0000000000000007')
    os.system('curl -X POST -d \'{"port_name": "rsu1-eth2", "type": "linux-htb", "max_rate": "9000000", "queues": [{"max_rate": "1000000"}, {"min_rate": "6000000"}]}\' http://localhost:8080/qos/queue/0000000000000006')
    os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000007')
    os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000006')  
    os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000006')
    os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000007')


    # os.system('curl -X POST -d \'{"type": "linux-htb", "max_rate": "9000000", "queues": [{"max_rate": "1000000"}, {"min_rate": "6000000"}]}\' http://localhost:8080/qos/queue/0000000000000008')
    # os.system('curl -X POST -d \'{"type": "linux-htb", "max_rate": "9000000", "queues": [{"max_rate": "1000000"}, {"min_rate": "6000000"}]}\' http://localhost:8080/qos/queue/0000000000000009')
    # os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000008')
    # os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000009')  
    # os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000008')
    # os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000009') 


    cars[0].cmdPrint("timeout 101 hping3 --udp -p 5002 -i u1300 -d 1470 200.0.10.2 -q &")
    cars[0].cmdPrint("ping 200.0.10.2 -i 1 -c 100  >> ping.txt &")


    time.sleep(100)

    server_s.cmd('pkill tcpdump')
    cars[0].cmd('pkill tcpdump') 

    cars[0].cmd('pkill hping3')
    # cars[0].cmd('pkill ping')
    cars[1].cmd('pkill hping3')
    cars[2].cmd('pkill hping3')
    server_s.cmd('iptables -D OUTPUT 1')
    server_e.cmd('iptables -D OUTPUT 1')
    server_e2.cmd('iptables -D OUTPUT 1')

    os.system('cat server.txt | grep IP | sed \'s/00:0/ 00:0/\' | tr -s \' \' | cut -d\' \' -f2,9,18 | cut -d\')\' -f1 | sed \'s/,//\'|cut -d\':\' -f2,3 | grep : > servert.txt; cat servert.txt | cut -d\'.\' -f2 > z.txt; cat servert.txt | cut -d\':\' -f1 | sed \'s/00/0*60/\' | sed \'s/01/1*60/\' | sed \'s/02/2*60/\' | sed \'s/03/3*60/\' | sed \'s/04/4*60/\'| sed \'s/05/5*60/\'| bc > x.txt; cat servert.txt | cut -d\':\' -f2 | cut -d\'.\' -f1 > y.txt; paste x.txt y.txt | expand | tr -s \' \' | tr \' \' \'+\' | bc > w.txt; cat z.txt | tr \' \' \'x\' >j.txt; paste w.txt j.txt | expand | tr -s \' \' | tr \' \' \'.\' | tr \'x\' \' \' > servertf.txt')
    os.system('cat car.txt | grep IP | sed \'s/00:0/ 00:0/\' | tr -s \' \' | cut -d\' \' -f2,9,18 | cut -d\')\' -f1 | sed \'s/,//\'|cut -d\':\' -f2,3 | grep : > cart.txt; cat cart.txt | cut -d\'.\' -f2 > z.txt; cat cart.txt | cut -d\':\' -f1 | sed \'s/00/0*60/\' | sed \'s/01/1*60/\' | sed \'s/02/2*60/\' | sed \'s/03/3*60/\' | sed \'s/04/4*60/\'| sed \'s/05/5*60/\'| bc > x.txt; cat cart.txt | cut -d\':\' -f2 | cut -d\'.\' -f1 > y.txt; paste x.txt y.txt | expand | tr -s \' \' | tr \' \' \'+\' | bc > w.txt; cat z.txt | tr \' \' \'x\' >j.txt; paste w.txt j.txt | expand | tr -s \' \' | tr \' \' \'.\' | tr \'x\' \' \' > cartf.txt')
    os.system('cat ping.txt |grep ms | cut -d\'=\' -f4 | grep -v % | cut -d\' \' -f1 > delay.txt')
    

    os.system('pkill xterm')

    print("*** Running CLI")
    CLI_wifi(net)


    print("*** Stopping network")
    net.stop()

if __name__ == '__main__':
    setLogLevel('info')
topology()