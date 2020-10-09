#!/usr/bin/python

#Before run emulation with this script, it is necessary run Ryu controller:
#ryu-manager ryu.app.rest_qos ryu.app.qos_simple_switch_13 ryu.app.rest_conf_switch ryu.app.ofctl_rest
#This script enbles three use cases: 1 - Using Framework (-f), only QoS (-q) and best effort (-b)
#All options require the script that will start applications traffic in vehicles (carcon.sh)
#To use -q option, it is necessary the database script (initialdb.sql) and Central Controller script (central_controller2.sh).
#To use -f option it is necessary databse script, Central controller and locar controllers script (local_controllers.sh)
#To generate the results its necessary to run after all the tratamento_c4.sh and the R scripts (comb_pdr.R, comb_delay.R and comb_geral.R)

'An Application driver Framework for ITS using SDN Vehicular Networks.'

import os
import time
import sys

from mininet.node import Controller, OVSKernelSwitch, RemoteController
from mn_wifi.node import OVSKernelAP #mudou
from mininet.log import setLogLevel, info
from mn_wifi.cli import CLI #modificado
from mn_wifi.net import Mininet_wifi
from mn_wifi.link import wmediumd
from mn_wifi.wmediumdConnector import interference
from mininet.link import TCLink
from mn_wifi.sumo.runner import sumo

def topology(flag):

    "Create a network."
    net = Mininet_wifi(controller=None, switch=OVSKernelSwitch, link=wmediumd, wmediumd_mode=interference, accessPoint=OVSKernelAP) #mudou
    c1 = net.addController( 'c1', controller=RemoteController, ip='127.0.0.1', port=6633 )

    info("*** Creating nodes\n")
    cars = []
    for x in range(0, 15):
        cars.append(x)

    cars[0] = net.addCar('car0',  wlans=1, ip='200.0.10.110/8', range = 50, mac='00:00:00:00:00:01', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[1] = net.addCar('car1',  wlans=1, ip='200.0.10.111/8', range = 50, mac='00:00:00:00:00:02', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[2] = net.addCar('car2',  wlans=1, ip='200.0.10.112/8', range = 50, mac='00:00:00:00:00:03', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[3] = net.addCar('car3',  wlans=1, ip='200.0.10.113/8', range = 50, mac='00:00:00:00:00:04', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[4] = net.addCar('car4',  wlans=1, ip='200.0.10.114/8', range = 50, mac='00:00:00:00:00:05', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[5] = net.addCar('car5',  wlans=1, ip='200.0.10.115/8', range = 50, mac='00:00:00:00:00:06', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[6] = net.addCar('car6',  wlans=1, ip='200.0.10.116/8', range = 50, mac='00:00:00:00:00:07', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[7] = net.addCar('car7',  wlans=1, ip='200.0.10.117/8', range = 50, mac='00:00:00:00:00:08', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[8] = net.addCar('car8',  wlans=1, ip='200.0.10.118/8', range = 50, mac='00:00:00:00:00:09', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[9] = net.addCar('car9',  wlans=1, ip='200.0.10.119/8', range = 50, mac='00:00:00:00:00:10', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[10] = net.addCar('car10',  wlans=1, ip='200.0.10.120/8', range = 50, mac='00:00:00:00:00:11', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[11] = net.addCar('car11',  wlans=1, ip='200.0.10.121/8', range = 50, mac='00:00:00:00:00:12', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[12] = net.addCar('car12',  wlans=1, ip='200.0.10.122/8', range = 50, mac='00:00:00:00:00:13', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[13] = net.addCar('car13',  wlans=1, ip='200.0.10.123/8', range = 50, mac='00:00:00:00:00:14', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou
    cars[14] = net.addCar('car14',  wlans=1, ip='200.0.10.124/8', range = 50, mac='00:00:00:00:00:15', encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou


    for x in range(15, 50): #15 vehicles
        cars.append(x)
    for i in range(15, 50):
        print("mac='00:01:00:00:00:%s'" %((int(i)-1)*1)) #84 a 99
        cars[i] = net.addCar('car%s' %i,  wlans=1, ip='200.0.9.%s/8' %(int(i)+10), range = 50, mac='00:01:00:00:00:%s' %((int(i)-1)*1), encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou

    # for x in range(81, 97): #16 vehicles
    #     cars.append(x)
    # for i in range(81, 97):
    #     print("mac='00:01:00:00:00:%s'" %((int(i)-114)*-1)) #  17 a 33
    #     cars[i] = net.addCar('car%s' %i,  wlans=1, ip='200.0.9.%s/8' %(int(i)+10), range = 50, mac='00:01:00:00:00:%s' %((int(i)-114)*-1), encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou

    # for x in range(147, 151): #4 vehicles
    #     cars.append(x)
    # for i in range(147, 151):
    #     print("mac='00:01:00:00:00:%s'" %((int(i)-113)*1)) # 34 a 38
    #     cars[i] = net.addCar('car%s' %i,  wlans=1, ip='200.0.9.%s/8' %(int(i)+10), range = 50, mac='00:01:00:00:00:%s' %((int(i)-113)*1), encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou

    #for i in range(105, 150):
     #   print("mac='00:02:00:00:00:%s'" %((int(i)-204)*-1))
      #  cars[i] = net.addCar('car%s' %i,  wlans=1, ip='200.0.9.%s/8' %(int(i)+10), range = 50, mac='00:02:00:00:00:%s' %((int(i)-204)*-1), encrypt=['wpa2'], bgscan_threshold=-60, s_interval=5, l_interval=10, bgscan_module="simple") #mudou


    rsu1 = net.addAccessPoint('rsu1', ssid='rsu1', mode='g', channel='1', range = 100, mac='00:00:00:11:00:01', passwd='123456789a',
                            encrypt='wpa2', protocols='OpenFlow13', position='2380.96,3714.27,0', config='ap_max_inactivity=6,' 'skip_inactivity_poll=1,' 'max_listen_interval=6')
    rsu2 = net.addAccessPoint('rsu2', ssid='rsu2', mode='g', channel='6', range = 100, mac='00:00:00:11:00:02', passwd='123456789a',
                            encrypt='wpa2', protocols='OpenFlow13', position='2615.91,3587.85,0', config='ap_max_inactivity=6,' 'skip_inactivity_poll=1,' 'max_listen_interval=6')
    rsu3 = net.addAccessPoint('rsu3', ssid='rsu3', mode='g', channel='11', range = 100, mac='00:00:00:11:00:03', passwd='123456789a',
                            encrypt='wpa2', protocols='OpenFlow13', position='2860.93,3456.58,0', config='ap_max_inactivity=6,' 'skip_inactivity_poll=1,' 'max_listen_interval=6')


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
    #net.propagationModel(model="logDistance", exp=4.5)
    net.setPropagationModel(model="logDistance", exp=2.8) #mudou

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

    link1 = net.addLink(sw1, sw2, 1, 4, cls=TCLink, bw=17) #mudou
    link2 = net.addLink(sw3, sw1, 3, 2, cls=TCLink, bw=5.25)
    link3 = net.addLink(sw4, sw1, 4, 3, cls=TCLink, bw=5.25)
    link4 = net.addLink(sw5, sw1, 5, 4, cls=TCLink, bw=5.25)

    net.useExternalProgram(program=sumo, port=8813,
                       config_file='map2.sumocfg')

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
    time.sleep(2)

    nodes = net.cars + net.aps
    net.telemetry(nodes=nodes, data_type='position',
                 min_x=2150, min_y=3200,
                 max_x=3250, max_y=3950)

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
    os.system('rm -f car*; rm -f server*; rm -f ping*; rm -f delay*; rm -f okok*; rm log*; /etc/init.d/network-manager stop')
    time.sleep(2)

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
    elif flag == '-b':
        print( "*** Using Best effort approach")
    else:
        print( "*** Using test version")


    #Configuring arp tables in servers (to avoid noise and inconsistent data)
    server_s1.cmd('arp -f ./mac2.txt &')
    server_s2.cmd('arp -f ./mac2.txt &')
    server_s3.cmd('arp -f ./mac2.txt &')
    server_e.cmd('arp -f ./mac2.txt &')
    server_e2.cmd('arp -f ./mac2.txt &')
    server_g.cmd('arp -f ./mac2.txt &')

    time.sleep(2)

    #Configuring arp tables in cars (to avoid noise and inconsistent data)
    for x in range(0,15):
        cars[x].cmd('arp -f ./mac.txt &')
        time.sleep(0.2)

    for x in range(15,50):
        cars[x].cmd('arp -f ./mac.txt &')
        time.sleep(0.2)

    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=4,dl_src=00:00:00:00:00:01 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:01 actions=4" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=4,dl_src=00:00:00:00:00:02 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:02 actions=4" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=4,dl_src=00:00:00:00:00:03 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:03 actions=4" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=2,dl_src=00:00:00:00:00:07 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:07 actions=2" -O Openflow13')
    os.system('ovs-ofctl add-flow sw2 "table=1, priority=1, cookie=0x0, in_port=1,dl_src=00:00:00:00:00:a3 actions=4" -O Openflow13')
    os.system('ovs-ofctl add-flow sw2 "table=1, priority=1, cookie=0x0, in_port=2,dl_src=00:00:00:00:00:a4 actions=4" -O Openflow13')
    os.system('ovs-ofctl add-flow sw2 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:a5 actions=4" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=4,dl_src=00:00:00:00:00:04 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:04 actions=4" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=4,dl_src=00:00:00:00:00:05 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:05 actions=4" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:06 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:06 actions=3" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:07 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:07 actions=3" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:08 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:08 actions=3" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:09 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:09 actions=3" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=3,dl_src=00:00:00:00:00:10 actions=1" -O Openflow13')
    os.system('ovs-ofctl add-flow sw1 "table=1, priority=1, cookie=0x0, in_port=1,dl_dst=00:00:00:00:00:10 actions=3" -O Openflow13')
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

    server_s1.cmd('tcpdump udp port 5002 -i server_s1-eth0 --direction=in -tttttnnvS --immediate-mode -l > server_s1.txt &')
    server_s2.cmd('tcpdump udp port 5002 -i server_s2-eth0 --direction=in -tttttnnvS --immediate-mode -l > server_s2.txt &')
    server_s3.cmd('tcpdump udp port 5002 -i server_s3-eth0 --direction=in -tttttnnvS --immediate-mode -l > server_s3.txt &')
    server_e.cmd('tcpdump udp port 5003 -i server_e-eth0 --direction=in -tttttnnvS --immediate-mode -l > server_e.txt &')
    server_e2.cmd('tcpdump udp port 5004 -i server_e2-eth0 --direction=in -tttttnnvS --immediate-mode -l > server_e2.txt &')
    server_g.cmd('tcpdump udp port 5005 -i server_g-eth0 --direction=in -tttttnnvS --immediate-mode -l > server_g.txt &')

    time.sleep(3)

    for x in range(0,15):
        cars[x].cmd('./framework_its_sdn/carcont.sh &')
        time.sleep(1)

    for x in range(15,50):
        cars[x].cmd('./framework_its_sdn/carcont2.sh &')
        time.sleep(1)


    info("*** Running CLI\n")
    CLI(net) #mudou

    info("*** Stopping network\n")
    net.stop()

    os.system('fuser -k ./framework_its_sdn/carcont.sh')
    os.system('fuser -k ./framework_its_sdn/carcont2.sh')

    #Kill processe using scripts pobile called
    #os.system('fuser -k ./framework_its_sdn/lc_mob.sh') 
    os.system('fuser -k ./framework_its_sdn/central_controller2.sh')
    os.system('fuser -k ./framework_its_sdn/local_controllers.sh')

if __name__ == '__main__':
    setLogLevel('info')
    # flag = True if '-lc' in sys.argv else False
    flag = sys.argv[1]
    #flag = 'none'
    if flag == '-f':
        print( "*** Using Framework...")
    elif  flag == '-q':
        print( "*** Using only Qos...")
    elif  flag == '-b':
        print( "*** Using best effort")
    else:
        print( "*** Test version")
    topology(flag)
