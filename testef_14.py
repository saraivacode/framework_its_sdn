#!/usr/bin/python

#Before run emulation with this script, is necessary run Ryu controller:
#ryu-manager ryu.app.rest_qos ryu.app.qos_simple_switch_13 ryu.app.rest_conf_switch ryu.app.ofctl_rest
#This program permits three use cases: 1 - Using Framework (-f), only QoS (-q) and best effort (-b)
#All options require the script that will start applications traffic in vehicles (carcon.sh)
#To use options -q, is necessary the database script (initialdb.sql) and Central Controller script (central_controller2.sh).
#To use option -f is necessary databse script, Central controller and locar controllers script (local_controllers.sh)
#To generate results its necessary run (after) tratamento_c3.sh and the R scripts (comb_pdr.R, comb_delay.R and comb_geral.R)

'An Application driver Framework for ITS using SDN Vehicular Networks.'

import os
import time
import sys

from mininet.node import Controller, OVSKernelSwitch, RemoteController
from mininet.log import setLogLevel, info
from mn_wifi.cli import CLI_wifi
from mn_wifi.net import Mininet_wifi
from mn_wifi.link import wmediumd
from mn_wifi.wmediumdConnector import interference
from mininet.link import TCLink

def topology(flag):

    "Create a network."
    net = Mininet_wifi(controller=None, switch=OVSKernelSwitch, link=wmediumd, wmediumd_mode=interference)
    c1 = net.addController( 'c1', controller=RemoteController, ip='127.0.0.1', port=6633 )

    info("*** Creating nodes\n")
    cars = []
    for x in range(0, 15):
        cars.append(x)

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

    rsu1 = net.addAccessPoint('rsu1', ssid='rsu1', mode='g', channel='1', range='250', position='1100,250,0', protocols='OpenFlow13')
    rsu2 = net.addAccessPoint('rsu2', ssid='rsu2', mode='g', channel='6', range='250', position='1600,250,0', protocols='OpenFlow13')
    rsu3 = net.addAccessPoint('rsu3', ssid='rsu3', mode='g', channel='11', range='250', position='2100,250,0', protocols='OpenFlow13')

    sw1 = net.addSwitch ('sw1', dpid='9', protocols='OpenFlow13')
    sw2 = net.addSwitch ('sw2', dpid='10', protocols='OpenFlow13')
    sw3 = net.addSwitch ('sw3', dpid='11', protocols='OpenFlow13')
    sw4 = net.addSwitch ('sw4', dpid='12', protocols='OpenFlow13')
    sw5 = net.addSwitch ('sw5', dpid='13', protocols='OpenFlow13')

    server_s1 = net.addHost ('server_s1', ip='200.0.10.2/8', mac='00:00:00:00:00:a2')
    server_s2 = net.addHost ('server_s2', ip='200.0.10.2/8', mac='00:00:00:00:00:a2')
    server_s3 = net.addHost ('server_s3', ip='200.0.10.2/8', mac='00:00:00:00:00:a2')
    server_e = net.addHost ('server_e', ip='200.0.10.3/8', mac='00:00:00:00:00:a3')
    server_e2 = net.addHost ('server_e2', ip='200.0.10.4/8', mac='00:00:00:00:00:a4')
    server_g = net.addHost ('server_g', ip='200.0.10.5/8', mac='00:00:00:00:00:a5')

    info("*** Configuring Propagation Model\n")
    net.propagationModel(model="logDistance", exp=4.5)
    
    info("*** Configuring wifi nodes\n")
    net.configureWifiNodes()
    
    print("*** Creating links")
    net.addLink(rsu1, rsu2, 2, 2)
    net.addLink(rsu2, rsu3, 3, 2)
    net.addLink(server_s1, rsu1, 0, 5)
    net.addLink(server_s2, rsu2, 0, 5)
    net.addLink(server_s3, rsu3, 0, 5)
    net.addLink(server_e, sw2, 0, 1)
    net.addLink(server_e2, sw2, 0, 2)
    net.addLink(server_g, sw2, 0, 3)
    net.addLink(sw3, rsu1, 1, 3)
    net.addLink(sw4, rsu2, 2, 4)
    net.addLink(sw5, rsu3, 3, 3)
    link1 = net.addLink(sw1, sw2, 1, 4, cls=TCLink )
    link2 = net.addLink(sw3, sw1, 3, 2, cls=TCLink)
    link3 = net.addLink(sw4, sw1, 4, 3, cls=TCLink)
    link4 = net.addLink(sw5, sw1, 5, 4, cls=TCLink)

    print( "*** Configuring links bandwidth" )
    link1.intf1.config( bw=17 )
    link2.intf1.config( bw=5.25 )
    link3.intf1.config( bw=5.25 )
    link4.intf1.config( bw=5.25 )

    net.plotGraph(max_x=2400, max_y=500)
    
    #starting scenarios
    print("*** Starting network")
    net.build()
    c1.start()
    rsu1.start([c1])
    rsu2.start([c1])
    rsu3.start([c1])
    sw1.start([c1])
    sw2.start([c1])
    sw3.start([c1])
    sw4.start([c1])
    sw5.start([c1])
    #Necessary to avoid icmp noise
    server_s1.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    server_s2.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    server_s3.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    server_e.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    server_e2.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    server_g.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    time.sleep(1)
    #Defining DPID of RSUs 
    os.system('ovs-vsctl set bridge rsu1 other-config:datapath-id=0000000000000006')
    os.system('ovs-vsctl set bridge rsu2 other-config:datapath-id=0000000000000007')
    os.system('ovs-vsctl set bridge rsu3 other-config:datapath-id=0000000000000008')
    #Cleaning old QoS rules and Queues
    os.system('ovs-vsctl --all destroy QoS; ovs-vsctl --all destroy Queue')
    #Setting manager in OVS to Ryu
    os.system('ovs-vsctl set-manager ptcp:6632')
    time.sleep(1)
    #configuring OVSDB in Ryu, using REST API
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000006/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000007/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000008/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000009/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000010/ovsdb_addr')

    # print( "*** Creating initial basic flows in network" )
    time.sleep(1)
    os.system('ovs-ofctl del-flows sw1 -O Openflow13; ovs-ofctl add-flow sw1 "table=0, priority=0, actions=goto_table:1" -O Openflow13;')
    os.system('ovs-ofctl del-flows sw2 -O Openflow13; ovs-ofctl add-flow sw2 "table=0, priority=0, actions=goto_table:1" -O Openflow13;\
        ovs-ofctl add-flow sw2 "table=1, priority=0, actions=CONTROLLER:65535" -O Openflow13;')
    os.system('ovs-ofctl del-flows sw3 -O Openflow13; ovs-ofctl add-flow sw3 "table=0, priority=0, actions=goto_table:1" -O Openflow13;\
        ovs-ofctl add-flow sw3 "table=1, priority=0, in_port=3 actions=1" -O Openflow13; ovs-ofctl add-flow sw3 "table=1, priority=0,\
        in_port=1 actions=3" -O Openflow13;')
    os.system('ovs-ofctl del-flows sw4 -O Openflow13; ovs-ofctl add-flow sw4 "table=0, priority=0, actions=goto_table:1" -O Openflow13;\
        ovs-ofctl add-flow sw4 "table=1, priority=0, in_port=2 actions=4" -O Openflow13; ovs-ofctl add-flow sw4 "table=1, priority=0,\
        in_port=4 actions=2" -O Openflow13;')
    os.system('ovs-ofctl del-flows sw5 -O Openflow13; ovs-ofctl add-flow sw5 "table=0, priority=0, actions=goto_table:1" -O Openflow13;\
        ovs-ofctl add-flow sw5 "table=1, priority=0, in_port=3 actions=5" -O Openflow13; ovs-ofctl add-flow sw5 "table=1, priority=0,\
        in_port=5 actions=3" -O Openflow13;')
    os.system('ovs-ofctl del-flows rsu1 -O Openflow13; ovs-ofctl add-flow rsu1 "table=0, priority=0, actions=goto_table:1" -O Openflow13;\
        ovs-ofctl add-flow rsu1 "table=1, priority=0, in_port=1, actions=3" -O Openflow13; ovs-ofctl add-flow rsu1 "table=1, priority=0, \
        in_port=3, actions=1" -O Openflow13; ovs-ofctl add-flow rsu1 "table=1, priority=1, cookie=0x28, in_port=1, nw_dst=200.0.10.2,icmp \
        actions=5" -O Openflow13; ovs-ofctl add-flow rsu1 "table=1, priority=1, cookie=0x28,in_port=5, actions=1" -O Openflow13; ovs-ofctl\
        add-flow rsu1 "table=1, priority=1, cookie=0x28, in_port=1, nw_dst=200.0.10.2,udp,tp_dst=5002 actions=5" -O Openflow13;')
    os.system('ovs-ofctl del-flows rsu2 -O Openflow13; ovs-ofctl add-flow rsu2 "table=0, priority=0, actions=goto_table:1" -O Openflow13;\
        ovs-ofctl add-flow rsu2 "table=1, priority=0, in_port=1, actions=4" -O Openflow13; ovs-ofctl add-flow rsu2 "table=1, priority=0, \
        in_port=4, actions=1" -O Openflow13; ovs-ofctl add-flow rsu2 "table=1, priority=1, cookie=0x28, in_port=1, nw_dst=200.0.10.2,icmp\
        actions=5" -O Openflow13; ovs-ofctl add-flow rsu2 "table=1, priority=1, cookie=0x28,in_port=5, actions=1" -O Openflow13; ovs-ofctl \
        add-flow rsu2 "table=1, priority=1, cookie=0x28, in_port=1, nw_dst=200.0.10.2,udp,tp_dst=5002 actions=5" -O Openflow13;')
    os.system('ovs-ofctl del-flows rsu3 -O Openflow13; ovs-ofctl add-flow rsu3 "table=0, priority=0, actions=goto_table:1" -O Openflow13; \
        ovs-ofctl add-flow rsu3 "table=1, priority=0, in_port=1, actions=3" -O Openflow13; ovs-ofctl add-flow rsu3 "table=1, priority=0, \
        in_port=3, actions=1" -O Openflow13; ovs-ofctl add-flow rsu3 "table=1, priority=1, cookie=0x28, in_port=1, nw_dst=200.0.10.2,icmp \
        actions=5" -O Openflow13; ovs-ofctl add-flow rsu3 "table=1, priority=1, cookie=0x28,in_port=5, actions=1" -O Openflow13; ovs-ofctl \
        add-flow rsu3 "table=1, priority=1, cookie=0x28, in_port=1, nw_dst=200.0.10.2,udp,tp_dst=5002 actions=5" -O Openflow13;')
    
    #Removing trace files and stopping network manager
    os.system('rm -f car*; rm -f server*; rm -f ping*; rm -f delay*; rm log*; /etc/init.d/network-manager stop')
    time.sleep(2)

    #Automatic mobility (disabled to these experiments)
    #os.system('./framework_its_sdn/lc_mob.sh > j2.txt &')

    #Define the way the approach that will be used (Framework, only QoS or best effort)
    if flag == '-f':
        print( "*** Using Framework with controllers database, central controller and local controllers scripts")
        os.system('mysql -u root -pwifi < ./framework_its_sdn/initialdb.sql -f &')
        time.sleep(4)
        os.system('./framework_its_sdn/central_controller2.sh > j1.txt &')
        time.sleep(4)
        os.system('./framework_its_sdn/local_controllers.sh > j3.txt &')
    elif flag == '-q':
        print( "*** Using Only QoQ approach")
        os.system('mysql -u root -pwifi < ./framework_its_sdn/initialdb.sql -f &')
        time.sleep(4)
        os.system('./framework_its_sdn/central_controller2.sh > j1.txt &')
    else:
        print( "*** Using Best effort approach")

    #Configuring arp table in servers (to avoid noise and inconsistent data)
    server_s1.cmd('arp -f ./mac2.txt &')
    server_s2.cmd('arp -f ./mac2.txt &')
    server_s3.cmd('arp -f ./mac2.txt &')
    server_e.cmd('arp -f ./mac2.txt &')
    server_e2.cmd('arp -f ./mac2.txt &')
    server_g.cmd('arp -f ./mac2.txt &')

    time.sleep(2)

    #Configuring arp table in cars (to avoid noise and inconsistent data)
    for x in xrange(0,15):
        cars[x].cmd('arp -f ./mac.txt &')
        time.sleep(0.5)

    #starting tcpdump in servers, to collect packets in order to generate results
    server_s1.cmd('tcpdump udp port 5002 -i server_s1-eth0 --direction=in -tttttnnvS --immediate-mode -l > server_s1.txt &')
    server_s2.cmd('tcpdump udp port 5002 -i server_s2-eth0 --direction=in -tttttnnvS --immediate-mode -l > server_s2.txt &')
    server_s3.cmd('tcpdump udp port 5002 -i server_s3-eth0 --direction=in -tttttnnvS --immediate-mode -l > server_s3.txt &')
    server_e.cmd('tcpdump udp port 5003 -i server_e-eth0 --direction=in -tttttnnvS --immediate-mode -l > server_e.txt &')
    server_e2.cmd('tcpdump udp port 5004 -i server_e2-eth0 --direction=in -tttttnnvS --immediate-mode -l > server_e2.txt &')
    server_g.cmd('tcpdump udp port 5005 -i server_g-eth0 --direction=in -tttttnnvS --immediate-mode -l > server_g.txt &')

    print( "*** Starting C1 - T1")
    # Car0, 1 and 2 in RSU3. Car3 and 4 in RSU2 and Car 5 and 6 in RSU1. Cars7-14 out of range
    #Configuring flows to vehicles in backbonne switch
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=4,dl_src=00:00:00:00:00:01 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:01 actions=4" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=4,dl_src=00:00:00:00:00:02 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:02 actions=4" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=4,dl_src=00:00:00:00:00:03 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:03 actions=4" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:04 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:04 actions=3" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:05 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:05 actions=3" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=2,dl_src=00:00:00:00:00:06 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:06 actions=2" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=2,dl_src=00:00:00:00:00:07 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:07 actions=2" -O Openflow13')
    os.system('ovs-ofctl add-flow sw2 "table=1, priority=1, cookie=0x0, in_port=1,dl_src=00:00:00:00:00:a3 actions=4" -O Openflow13')
    os.system('ovs-ofctl add-flow sw2 "table=1, priority=1, cookie=0x0, in_port=2,dl_src=00:00:00:00:00:a4 actions=4" -O Openflow13')
    os.system('ovs-ofctl add-flow sw2 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:a5 actions=4" -O Openflow13')

    time.sleep(5)

    #Starting applications in vehicles
    for x in xrange(0,15):
        cars[x].cmd('./framework_its_sdn/carcon.sh &')
        # time.sleep(1)

    #Waiting the Congestion Level 1 time
    time.sleep(75)

    #Starting the Congestion Level 2 - moving vehicles 3, 4 and 5
    # Car0, 1, 2 3 and 4 in RSU3. Car5 in RSU2 and Car6 in RSU1. Cars7-14 out of range
    print( "*** Starting C2 - T2")
    cars[3].setPosition('2104,247,0')
    cars[4].setPosition('2101,250,0')
    cars[5].setPosition('1607,247,0')
    #configuring flows of vehicles 3, 4 and 5 in backbone
    os.system('ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=00:00:00:00:00:04 -O Openflow13')
    os.system('ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=00:00:00:00:00:04 -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=4,dl_src=00:00:00:00:00:04 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:04 actions=4" -O Openflow13')
    os.system('ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=00:00:00:00:00:05 -O Openflow13')
    os.system('ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=00:00:00:00:00:05 -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=4,dl_src=00:00:00:00:00:05 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:05 actions=4" -O Openflow13')
    os.system('ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=00:00:00:00:00:06 -O Openflow13')
    os.system('ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=00:00:00:00:00:06 -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:06 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:06 actions=3" -O Openflow13')
    #Waiting the Congestion Level 2 time
    time.sleep(75)
    #Starting the Congestion Level 3 - moving vehicles 6, 7, 8, 9 and 10
    # Car0-4 in RSU3. Car5-8 in RSU2 and Car9-10 in RSU1. Cars11-14 out of range
    print( "*** Starting C3 - T3")
    cars[6].setPosition('1604,247,0')
    cars[7].setPosition('1607,250,0')
    cars[8].setPosition('1601,247,0')
    cars[9].setPosition('1107,250,0')
    cars[10].setPosition('1104,247,0')
    #Configuring flows to vehicles in backbone switch
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:07 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:07 actions=3" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:08 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:08 actions=3" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:09 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:09 actions=3" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=2,dl_src=00:00:00:00:00:10 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:10 actions=2" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=2,dl_src=00:00:00:00:00:11 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:11 actions=2" -O Openflow13')
    #Waiting the Congestion Level 3 time
    time.sleep(75)
    #Starting the Congestion Level 4 - moving vehicles 9, 10, 11, 12, 13 and 14
    # Car0-4 in RSU3. Car5-10 in RSU2 and Car11-14 in RSU1. All RSUs in range
    print( "*** Starting C4 - T4")
    cars[9].setPosition('1604,250,0')
    cars[10].setPosition('1601,250,0')
    cars[11].setPosition('1107,250,0')
    cars[12].setPosition('1107,247,0')
    cars[13].setPosition('1104,250,0')
    cars[14].setPosition('1104,247,0')
    #Configuring flows to vehicles in backbone switch
    os.system('ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=00:00:00:00:00:10 -O Openflow13')
    os.system('ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=00:00:00:00:00:10 -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:10 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:10 actions=3" -O Openflow13')
    os.system('ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_src=00:00:00:00:00:11 -O Openflow13')
    os.system('ovs-ofctl del-flows sw1 cookie=0x0/-1,dl_dst=00:00:00:00:00:11 -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:11 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:11 actions=3" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=2,dl_src=00:00:00:00:00:12 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:12 actions=2" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=2,dl_src=00:00:00:00:00:13 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:13 actions=2" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=2,dl_src=00:00:00:00:00:14 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:14 actions=2" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=2,dl_src=00:00:00:00:00:15 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:15 actions=2" -O Openflow13')
    #Waiting the Congestion Level 4 time
    time.sleep(85)

    #Finishing process
    os.system('pkill tcpdump')
    os.system('pkill hping3')
    os.system('pkill ping')
    time.sleep(2)

    info("*** Running CLI\n")
    CLI_wifi(net)

    info("*** Stopping network\n")
    net.stop()

    #Kill processe using scripts pobile called
    os.system('fuser -k ./framework_its_sdn/lc_mob.sh') 
    os.system('fuser -k ./framework_its_sdn/central_controller2.sh')
    os.system('fuser -k ./framework_its_sdn/local_controllers.sh')

if __name__ == '__main__':
    setLogLevel('info')
    # flag = True if '-lc' in sys.argv else False
    flag = sys.argv[1]
    if flag == '-f':
        print( "*** Using Framework...")
    elif  flag == '-q':
        print( "*** Using only Qos...")
    else:
        print( "*** Using best effort")
    topology(flag)
