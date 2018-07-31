#!/usr/bin/python

"""

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

    ncars = 6

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
    cars[0] = net.addCar('car0', wlans=1, range='30', ip='200.0.10.110/8', mac='00:00:00:00:00:01', mode='b', position='25,125,0')
    cars[1] = net.addCar('car1', wlans=1, range='30', ip='200.0.10.120/8', mac='00:00:00:00:00:02', mode='b', position='30,125,0')
    cars[2] = net.addCar('car2', wlans=1, range='30', ip='200.0.10.130/8', mac='00:00:00:00:00:03', mode='b', position='35,125,0')
    cars[3] = net.addCar('car3', wlans=1, range='30', ip='200.0.10.140/8', mac='00:00:00:00:00:04', mode='b', position='45,125,0')
    cars[4] = net.addCar('car4', wlans=1, range='30', ip='200.0.10.150/8', mac='00:00:00:00:00:05', mode='b', position='50,125,0')
    cars[5] = net.addCar('car5', wlans=1, range='30', ip='200.0.10.160/8', mac='00:00:00:00:00:06', mode='b', position='55,125,0')

    rsu1 = net.addAccessPoint('rsu1', ssid='rsu1', dpid='6', mode='g', channel='11',range='40', position='50,140,0', protocols='OpenFlow13')
    rsu2 = net.addAccessPoint('rsu2', ssid='rsu2', dpid='7', mode='g', channel='11', range='40', position='130,140,0', protocols='OpenFlow13')
    rsu3 = net.addAccessPoint('rsu3', ssid='rsu3', dpid='8', mode='g', channel='11', range='40', position='210,140,0', protocols='OpenFlow13')
   
    sw1 = net.addSwitch ('sw1', dpid='9', protocols='OpenFlow13')
    sw2 = net.addSwitch ('sw2', dpid='10', protocols='OpenFlow13')

    server_s = net.addHost ('server_s', ip='200.0.10.2/8')
    server_e = net.addHost ('server_e', ip='200.0.10.3/8')
    server_e2 = net.addHost ('server_e2', ip='200.0.10.4/8')
    
    server_s.plot(position='210,190,0')
    server_e.plot(position='210,220,0')
    server_e2.plot(position='210,240,0')

    sw1.plot(position='125,218,0')
    sw2.plot(position='170,218,0')

    print("*** Configuring Propagation Model")
    net.propagationModel(model="logDistance", exp=4.5)

    net.useIFB()

    print("*** Configuring wifi nodes")
    net.configureWifiNodes()

    print("*** Creating links")
    net.addLink(rsu1, rsu2)
    net.addLink(rsu2, rsu3)
    net.addLink(server_s, sw2)
    net.addLink(server_e, sw2)
    net.addLink(server_e2, sw2)
    link1 = net.addLink(sw1, sw2, cls=TCLink )
    link2 = net.addLink(rsu1, sw1, cls=TCLink)
    link3 = net.addLink(rsu2, sw1, cls=TCLink)
    link4 = net.addLink(rsu3, sw1, cls=TCLink)


    print( "*** Configuring links bandwidth" )
    link1.intf1.config( bw=9 )
    link2.intf1.config( bw=6 )
    link3.intf1.config( bw=6 )
    link4.intf1.config( bw=6 )

    'Plotting Graph'
    net.plotGraph(max_x=250, max_y=250)

    print("*** Starting network")
    net.build()
    c1.start()
    rsu1.start([c1])
    rsu2.start([c1])
    rsu3.start([c1])
    sw1.start([c1])
    sw2.start([c1])

    for sw in net.carsSW:
        sw.start([c1])

    server_s.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    server_e.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    server_e2.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')

    
    # os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000006')

    # os.system('ovs-ofctl mod-port rsu1 rsu1-eth3 down -O Openflow13')
    # os.system('ovs-ofctl mod-port rsu2 rsu2-eth3 down -O Openflow13')
    # os.system('ovs-ofctl mod-port rsu2 rsu2-eth4 down -O Openflow13')
    # os.system('ovs-ofctl mod-port rsu3 rsu3-eth3 down -O Openflow13')

    #colocando a porta em up
    #os.system(curl -X POST -d '{ "dpid": 55930, "port_no": 103, "config": 0, "mask": 1,}' http://localhost:8080/stats/portdesc/modify)


    # time.sleep(1)
    # makeTerm(cars[0], cmd="bash -c 'ping 200.0.10.2;'")

    os.system('ovs-vsctl --all destroy QoS; ovs-vsctl --all destroy Queue')

    os.system('ovs-vsctl set-manager ptcp:6632')

    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000006/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000007/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000008/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000009/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000010/ovsdb_addr')


    print( "*** Shutting ports" )
    #time.sleep(3)

    # os.system('curl -X POST -d \'{ "dpid": 0000000000000006, "port_no": 2, "config": 1, "mask": 1, }\' http://localhost:8080/stats/portdesc/modify')
    # os.system('curl -X POST -d \'{ "dpid": 0000000000000007, "port_no": 2, "config": 1, "mask": 1, }\' http://localhost:8080/stats/portdesc/modify')
    # os.system('curl -X POST -d \'{ "dpid": 0000000000000007, "port_no": 3, "config": 1, "mask": 1, }\' http://localhost:8080/stats/portdesc/modify')
    # os.system('curl -X POST -d \'{ "dpid": 0000000000000008, "port_no": 2, "config": 1, "mask": 1, }\' http://localhost:8080/stats/portdesc/modify')


    #Filtra trafego nas portas entre switches
    os.system('curl -X POST -d \'{ "dpid": 6, "cookie": 0, "cookie_mask": 1, "table_id": 1, "priority": 1, "flags": 2, "match":{ "in_port":2}, "actions":[{ "type":"CLEAR_ACTIONS"}]}\' http://localhost:8080/stats/flowentry/add')
    os.system('curl -X POST -d \'{ "dpid": 7, "cookie": 0, "cookie_mask": 1, "table_id": 1, "priority": 1, "flags": 2, "match":{ "in_port":2}, "actions":[{ "type":"CLEAR_ACTIONS"}]}\' http://localhost:8080/stats/flowentry/add')
    os.system('curl -X POST -d \'{ "dpid": 7, "cookie": 0, "cookie_mask": 1, "table_id": 1, "priority": 1, "flags": 2, "match":{ "in_port":3}, "actions":[{ "type":"CLEAR_ACTIONS"}]}\' http://localhost:8080/stats/flowentry/add')
    os.system('curl -X POST -d \'{ "dpid": 8, "cookie": 0, "cookie_mask": 1, "table_id": 1, "priority": 1, "flags": 2, "match":{ "in_port":2}, "actions":[{ "type":"CLEAR_ACTIONS"}]}\' http://localhost:8080/stats/flowentry/add')


    # print("*** Starting servers")
    # server_s.cmdPrint("iperf -s -u -i 1 -p 5002 > result_safety.datares &")
    # server_e.cmdPrint("iperf -s -u -i 1 -p 5003 > result_enter.datares &")
    # server_e2.cmdPrint("iperf -s -u -i 1 -p 5003 > result_enter2.datares &")
    # time.sleep(2)


    # print("*** Car[0] connection 7.5Mbps")
    # cars[0].cmdPrint("iperf -c 200.0.10.2 -p 5002 -u -b 1.5M -t130 &")
    # cars[1].cmdPrint("iperf -c 200.0.10.3 -p 5003 -u -b 1.5M -t100 &") 
    # cars[2].cmdPrint("iperf -c 200.0.10.4 -p 5003 -u -b 1.5M -t100 &")

    # timeout = time.time() + taskTime
    # currentTime = time.time()
    # i = 0
    # while True:
    #     if time.time() > timeout:
    #         break
    #     if time.time() - currentTime >= i:
    #        # recordValues(cars[0], server_s)
    #         i += 0.5

    print("*** Moving nodes")

    cars[0].setPosition('105,125,0')
    cars[1].setPosition('112,125,0')
    cars[2].setPosition('119,125,0')
    cars[3].setPosition('126,125,0')
    cars[4].setPosition('133,125,0')
    cars[5].setPosition('140,125,0')

    # while True:

    #     time.sleep(5)

    #     cars[0].setPosition('40,125,0')
    #     cars[1].setPosition('50,125,0')
    #     cars[2].setPosition('60,125,0')

    #     time.sleep(5)

    #     cars[0].setPosition('115,125,0')
    #     cars[1].setPosition('125,125,0')
    #     cars[2].setPosition('135,125,0')

    #     time.sleep(5)

    #     cars[0].setPosition('200,125,0')
    #     cars[1].setPosition('210,125,0')
    #     cars[2].setPosition('220,125,0')

        

    # os.system('ovs-ofctl del-flows sw1 -O Openflow13; ovs-ofctl add-flow sw1 "table=0, priority=0, actions=goto_table:1" -O Openflow13; ovs-ofctl add-flow sw1 "table=1, priority=0, actions=CONTROLLER:65535" -O Openflow13')

    # timeout = time.time() + taskTime
    # currentTime = time.time()
    # i = 0
    # while True:
    #     if time.time() > timeout:
    #         break
    #     if time.time() - currentTime >= i:
    #        # recordValues(cars[0], server_s)
    #         i += 0.5




    # os.system('ovs-ofctl del-flows sw1 -O Openflow13; ovs-ofctl add-flow sw1 "table=0, priority=0, actions=goto_table:1" -O Openflow13; ovs-ofctl add-flow sw1 "table=1, priority=0, actions=CONTROLLER:65535" -O Openflow13')


    # timeout = time.time() + taskTime
    # currentTime = time.time()
    # i = 0
    # while True:
    #     if time.time() > timeout:
    #         break
    #     if time.time() - currentTime >= i:
    #       #  recordValues(cars[0], server_s)
    #         i += 0.5

    # print("*** Aplica QoS")
    # os.system('curl -X POST -d \'{"port_name": "rsu2-eth2", "type": "linux-htb", "max_rate": "8300000", "queues": [{"max_rate": "1000000"}, {"min_rate": "7500000"}]}\' http://localhost:8080/qos/queue/0000000000000007')
    # os.system('curl -X POST -d \'{"port_name": "rsu1-eth2", "type": "linux-htb", "max_rate": "8300000", "queues": [{"max_rate": "1000000"}, {"min_rate": "7500000"}]}\' http://localhost:8080/qos/queue/0000000000000006')
    # os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000007')
    # os.system('curl -X POST -d \'{"match": {"nw_dst": "200.0.10.2", "nw_proto": "UDP", "tp_dst": "5002"}, "actions":{"queue": "1"}}\' http://localhost:8080/qos/rules/0000000000000006')

    # timeout = time.time() + taskTime
    # currentTime = time.time()
    # i = 0
    # while True:
    #     if time.time() > timeout:
    #         break
    #     if time.time() - currentTime >= i:
    #         recordValues(cars[0], server_s)
    #         i += 0.5



    # os.system('pkill -f vlc')
    os.system('pkill xterm')

    print("*** Running CLI")
    CLI_wifi(net)

    #os.system('rm *.vanetdata')

    server_s.cmd('iptables -D OUTPUT 1')
    server_e.cmd('iptables -D OUTPUT 1')
    server_e2.cmd('iptables -D OUTPUT 1')


    print("*** Stopping network")
    net.stop()

if __name__ == '__main__':
    setLogLevel('info')
topology()