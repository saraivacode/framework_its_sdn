#!/usr/bin/python

"""
ITS Application Driven Vehicular Networks
Video clip available at: https://www.youtube.com/watch?v=.....
"""

import os
import time

from mininet.node import Controller, OVSKernelSwitch, RemoteController
from mininet.log import setLogLevel, info
from mn_wifi.cli import CLI_wifi
from mn_wifi.net import Mininet_wifi
from mn_wifi.link import wmediumd
from mn_wifi.wmediumdConnector import interference
from mininet.link import TCLink




# from mininet.term import makeTerm

def topology():

    ncars = 15

    "Create a network."
    #net = Mininet_wifi(controller=None, autoStaticArp=True, switch=OVSKernelSwitch)
    net = Mininet_wifi(controller=None, switch=OVSKernelSwitch,
                       link=wmediumd, wmediumd_mode=interference)
    c1 = net.addController( 'c1', controller=RemoteController, ip='127.0.0.1', port=6633 )

    print("*** Creating nodes")
    cars = []
    stas = []
    for idx in range(0, ncars):
        cars.append(idx)
        stas.append(idx)

    #for idx in range(0, ncars):
    cars[0] = net.addCar('car0',  wlans=1, range='50', ip='200.0.10.110/8', mac='00:00:00:00:00:01', position='2107,250,0')
    cars[1] = net.addCar('car1',  wlans=1, range='50', ip='200.0.10.111/8', mac='00:00:00:00:00:02', position='2107,247,0')
    cars[2] = net.addCar('car2',  wlans=1, range='50', ip='200.0.10.112/8', mac='00:00:00:00:00:03', position='2104,250,0')

    cars[3] = net.addCar('car3',  wlans=1, range='50', ip='200.0.10.113/8', mac='00:00:00:00:00:04', position='1607,247,0')
    cars[4] = net.addCar('car4',  wlans=1, range='50', ip='200.0.10.114/8', mac='00:00:00:00:00:05', position='1604,250,0')

    cars[5] = net.addCar('car5',  wlans=1, range='50', ip='200.0.10.115/8', mac='00:00:00:00:00:06', position='1107,250,0')
    cars[6] = net.addCar('car6',  wlans=1, range='50', ip='200.0.10.116/8', mac='00:00:00:00:00:07', position='1104,247,0')

    cars[7] = net.addCar('car7',  wlans=1, range='50', ip='200.0.10.117/8', mac='00:00:00:00:00:08', position='150,250,0')
    cars[8] = net.addCar('car8',  wlans=1, range='50', ip='200.0.10.118/8', mac='00:00:00:00:00:09', position='200,250,0')
    cars[9] = net.addCar('car9',  wlans=1, range='50', ip='200.0.10.119/8', mac='00:00:00:00:00:10', position='250,250,0')
    cars[10] = net.addCar('car10',  wlans=1, range='50', ip='200.0.10.120/8', mac='00:00:00:00:00:11', position='300,250,0')
    cars[11] = net.addCar('car11',  wlans=1, range='50', ip='200.0.10.121/8', mac='00:00:00:00:00:12', position='350,250,0')
    cars[12] = net.addCar('car12',  wlans=1, range='50', ip='200.0.10.122/8', mac='00:00:00:00:00:13', position='400,243,0')
    cars[13] = net.addCar('car13',  wlans=1, range='50', ip='200.0.10.123/8', mac='00:00:00:00:00:14', position='450,243,0')
    cars[14] = net.addCar('car14',  wlans=1, range='50', ip='200.0.10.124/8', mac='00:00:00:00:00:15', position='500,243,0')
    
    rsu1 = net.addAccessPoint('rsu1', ssid='rsu1', dpid='0000000000000005', mode='g', channel='11',range=250, position='1100,250,0', protocols='OpenFlow13')
    rsu2 = net.addAccessPoint('rsu2', ssid='rsu2', dpid='0000000000000006', mode='g', channel='11', range=250, position='1600,250,0', protocols='OpenFlow13')
    rsu3 = net.addAccessPoint('rsu3', ssid='rsu3', dpid='0000000000000007', mode='g', channel='11', range=250, position='2100,250,0', protocols='OpenFlow13')

    sw1 = net.addSwitch ('sw1', dpid='0000000000000008', protocols='OpenFlow13', position='125,218,0')
    sw2 = net.addSwitch ('sw2', dpid='0000000000000009', protocols='OpenFlow13', position='170,218,0')

    server_s1 = net.addHost ('server_s1', ip='200.0.10.2/8')
    server_s2 = net.addHost ('server_s2', ip='200.0.10.2/8')
    server_s3 = net.addHost ('server_s3', ip='200.0.10.2/8')
    server_e = net.addHost ('server_e', ip='200.0.10.3/8')
    server_e2 = net.addHost ('server_e2', ip='200.0.10.4/8')
    server_g = net.addHost ('server_g', ip='200.0.10.5/8')
    
    print("*** Configuring Propagation Model")
    net.propagationModel(model="logDistance", exp=4.1)

    # net.useIFB()

    print("*** Configuring wifi nodes")
    net.configureWifiNodes()

    print("*** Creating links")
    net.addLink(server_s1, rsu1, 0, 5)
    net.addLink(server_s2, rsu2, 0, 5)
    net.addLink(server_s3, rsu3, 0, 5)
    # net.addLink(rsu1, sw1, 3, 4)
    # net.addLink(rsu2, sw1, 4, 3)
    # net.addLink(rsu3, sw1, 3, 2)
    net.addLink(server_g, sw2)
    net.addLink(server_e, sw2)
    net.addLink(server_e2, sw2)
    link1 = net.addLink( sw1, sw2, cls=TCLink )
    link2 = net.addLink(rsu1, sw1, 3, 2, cls=TCLink)
    link3 = net.addLink(rsu2, sw1, 4, 3, cls=TCLink)
    link4 = net.addLink(rsu3, sw1, 3, 4, cls=TCLink)

    print( "*** Configuring links bandwidth" )
    # link1.intf1.config( bw=17 )
    link2.intf1.config( bw=5.5 )
    link3.intf1.config( bw=5.5 )
    link4.intf1.config( bw=5.5 )

    net.plotGraph(max_x=2400, max_y=500)

    print("*** Starting network")
    net.build()
    c1.start()
    rsu1.start([c1])
    rsu2.start([c1])
    rsu3.start([c1])
    sw1.start([c1])
    sw2.start([c1])

    # for sw in net.carsSW:
    #     sw.start([c1])

    os.system('ovs-vsctl set bridge rsu1 other-config:datapath-id=0000000000000005')
    os.system('ovs-vsctl set bridge rsu2 other-config:datapath-id=0000000000000006')
    os.system('ovs-vsctl set bridge rsu3 other-config:datapath-id=0000000000000007')
    os.system('ovs-vsctl set bridge sw1 other-config:datapath-id=0000000000000008')
    os.system('ovs-vsctl set bridge sw2 other-config:datapath-id=0000000000000009')

    time.sleep(2)

    os.system('ovs-vsctl --all destroy QoS; ovs-vsctl --all destroy Queue')

    os.system('ovs-vsctl set-manager ptcp:6632')

    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000005/ovsdb_addr')
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


    # server_s1.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    server_e.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    server_e2.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')

    # time.sleep(1)

    # print("*** Car[0] connection 7.5Mbps")
    # cars[0].cmdPrint("timeout 205 hping3 --udp -p 5002 -i u1400 -d 1470 200.0.10.2 -q &")
    # time.sleep(2)

    # cars[0].cmd('tcpdump udp port 5002 -i car0-wlan0 --direction=out -tttttnnvS > car.txt &')
    # server_s.cmd('tcpdump udp port 5002 -i server_s-eth0 --direction=in -tttttnnvS > server.txt &')
    # # cars[0].cmdPrint("ping 200.0.10.2 -i 1 -c %s  > ping.txt &", % timeout)
    # cars[0].cmdPrint("ping 200.0.10.2 -i 1 -c 205  > ping.txt &")
    # # makeTerm(cars[0], cmd="ping 200.0.10.2 -i 1")
    
    # print("*** Deu certo!")

    # time.sleep(105)

    # print("*** Car[1] e car[2] iniciam em paralelo - 7.5Mbps cada")
    # cars[1].cmdPrint("timeout 205 hping3 --udp -p 5003 -i u1400 -d 1470 200.0.10.3 -q &") 
    # cars[2].cmdPrint("timeout 205 hping3 --udp -p 5004 -i u1400 -d 1470 200.0.10.4 -q &")

    # time.sleep(100)

    # print("*** Aplica QoS")
    # os.system('curl -X POST -d \'{"port_name": "rsu2-eth2", "type": "linux-htb", "max_rate": "9000000", "queues": [{"max_rate": "1000000"}, {"min_rate": "6000000"}]}\' http://localhost:8080/qos/queue/0000000000000007')
    # os.system('curl -X POST -d \'{"port_name": "rsu1-eth2", "type": "linux-htb", "max_rate": "9000000", "queues": [{"max_rate": "1000000"}, {"min_rate": "6000000"}]}\' http://localhost:8080/qos/queue/0000000000000006')
    # os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000007')
    # os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000006')  
    # os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000006')
    # os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000007')


    print("*** Aplica QoS")
    os.system('curl -X POST -d \'{"port_name": "rsu1-eth3", "type": "linux-htb", "max_rate": "6000000", "queues": [{"max_rate": "500000"}, {"min_rate": "0"}, {"min_rate": "500000"}, {"min_rate": "1000000"}]}\' http://localhost:8080/qos/queue/0000000000000005')
    os.system('curl -X POST -d \'{"port_name": "rsu2-eth4", "type": "linux-htb", "max_rate": "6000000", "queues": [{"max_rate": "500000"}, {"min_rate": "0"}, {"min_rate": "500000"}, {"min_rate": "1000000"}]}\' http://localhost:8080/qos/queue/0000000000000006')
    os.system('curl -X POST -d \'{"port_name": "rsu3-eth3", "type": "linux-htb", "max_rate": "6000000", "queues": [{"max_rate": "500000"}, {"min_rate": "0"}, {"min_rate": "500000"}, {"min_rate": "1000000"}]}\' http://localhost:8080/qos/queue/0000000000000007')
    
    os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000005')
    os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000006')  
    os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000007')  
    os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP", "nw_dst": "200.0.10.2"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000005')
    os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP", "nw_dst": "200.0.10.2"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000006')
    os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP", "nw_dst": "200.0.10.2"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000007')

    os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.3", "nw_proto": "UDP", "tp_dst": "5003"}, "actions":{"queue": "2"}}\' http://localhost:8080/qos/rules/0000000000000005')
    os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.3", "nw_proto": "UDP", "tp_dst": "5003"}, "actions":{"queue": "2"}}\' http://localhost:8080/qos/rules/0000000000000006')  
    os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.3", "nw_proto": "UDP", "tp_dst": "5003"}, "actions":{"queue": "2"}}\' http://localhost:8080/qos/rules/0000000000000007')  
    os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP", "nw_dst": "200.0.10.3"}, "actions":{"queue": "2"}}\' http://localhost:8080/qos/rules/0000000000000005')
    os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP", "nw_dst": "200.0.10.3"}, "actions":{"queue": "2"}}\' http://localhost:8080/qos/rules/0000000000000006')
    os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP", "nw_dst": "200.0.10.3"}, "actions":{"queue": "2"}}\' http://localhost:8080/qos/rules/0000000000000007')

    os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.4", "nw_proto": "UDP", "tp_dst": "5004"}, "actions":{"queue": "3"}}\' http://localhost:8080/qos/rules/0000000000000005')
    os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.4", "nw_proto": "UDP", "tp_dst": "5004"}, "actions":{"queue": "3"}}\' http://localhost:8080/qos/rules/0000000000000006')
    os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.4", "nw_proto": "UDP", "tp_dst": "5004"}, "actions":{"queue": "3"}}\' http://localhost:8080/qos/rules/0000000000000007')  
    os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP", "nw_dst": "200.0.10.4"}, "actions":{"queue": "3"}}\' http://localhost:8080/qos/rules/0000000000000005')
    os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP", "nw_dst": "200.0.10.4"}, "actions":{"queue": "3"}}\' http://localhost:8080/qos/rules/0000000000000006')
    os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP", "nw_dst": "200.0.10.4"}, "actions":{"queue": "3"}}\' http://localhost:8080/qos/rules/0000000000000007')


    # os.system('curl -X POST -d \'{"type": "linux-htb", "max_rate": "9000000", "queues": [{"max_rate": "1000000"}, {"min_rate": "6000000"}]}\' http://localhost:8080/qos/queue/0000000000000008')
    # os.system('curl -X POST -d \'{"type": "linux-htb", "max_rate": "9000000", "queues": [{"max_rate": "1000000"}, {"min_rate": "6000000"}]}\' http://localhost:8080/qos/queue/0000000000000009')
    # os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000008')
    # os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000009')  
    # os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000008')
    # os.system('curl -X POST -d \'{"match": {"nw_proto": "ICMP"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000009') 


    # cars[0].cmdPrint("timeout 101 hping3 --udp -p 5002 -i u1300 -d 1470 200.0.10.2 -q &")
    # cars[0].cmdPrint("ping 200.0.10.2 -i 1 -c 100  >> ping.txt &")


    # time.sleep(100)

    # server_s.cmd('pkill tcpdump')
    # cars[0].cmd('pkill tcpdump') 

    # cars[0].cmd('pkill hping3')
    # # cars[0].cmd('pkill ping')
    # cars[1].cmd('pkill hping3')
    # cars[2].cmd('pkill hping3')
    # server_s.cmd('iptables -D OUTPUT 1')
    # server_e.cmd('iptables -D OUTPUT 1')
    # server_e2.cmd('iptables -D OUTPUT 1')

    # os.system('cat server.txt | grep IP | sed \'s/00:0/ 00:0/\' | tr -s \' \' | cut -d\' \' -f2,9,18 | cut -d\')\' -f1 | sed \'s/,//\'|cut -d\':\' -f2,3 | grep : > servert.txt; cat servert.txt | cut -d\'.\' -f2 > z.txt; cat servert.txt | cut -d\':\' -f1 | sed \'s/00/0*60/\' | sed \'s/01/1*60/\' | sed \'s/02/2*60/\' | sed \'s/03/3*60/\' | sed \'s/04/4*60/\'| sed \'s/05/5*60/\'| bc > x.txt; cat servert.txt | cut -d\':\' -f2 | cut -d\'.\' -f1 > y.txt; paste x.txt y.txt | expand | tr -s \' \' | tr \' \' \'+\' | bc > w.txt; cat z.txt | tr \' \' \'x\' >j.txt; paste w.txt j.txt | expand | tr -s \' \' | tr \' \' \'.\' | tr \'x\' \' \' > servertf.txt')
    # os.system('cat car.txt | grep IP | sed \'s/00:0/ 00:0/\' | tr -s \' \' | cut -d\' \' -f2,9,18 | cut -d\')\' -f1 | sed \'s/,//\'|cut -d\':\' -f2,3 | grep : > cart.txt; cat cart.txt | cut -d\'.\' -f2 > z.txt; cat cart.txt | cut -d\':\' -f1 | sed \'s/00/0*60/\' | sed \'s/01/1*60/\' | sed \'s/02/2*60/\' | sed \'s/03/3*60/\' | sed \'s/04/4*60/\'| sed \'s/05/5*60/\'| bc > x.txt; cat cart.txt | cut -d\':\' -f2 | cut -d\'.\' -f1 > y.txt; paste x.txt y.txt | expand | tr -s \' \' | tr \' \' \'+\' | bc > w.txt; cat z.txt | tr \' \' \'x\' >j.txt; paste w.txt j.txt | expand | tr -s \' \' | tr \' \' \'.\' | tr \'x\' \' \' > cartf.txt')
    # os.system('cat ping.txt |grep ms | cut -d\'=\' -f4 | grep -v % | cut -d\' \' -f1 > delay.txt')
    

    os.system('pkill xterm')

    print("*** Running CLI")
    CLI_wifi(net)


    print("*** Stopping network")
    net.stop()

if __name__ == '__main__':
    setLogLevel('info')
topology()