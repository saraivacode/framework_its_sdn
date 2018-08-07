#!/usr/bin/python

"""

"""

import os
import random

from mininet.node import Controller, OVSKernelSwitch
from mininet.log import setLogLevel, info
from mininet.wifi.cli import CLI_wifi
from mininet.wifi.net import Mininet_wifi
from mininet.wifi.link import wmediumd
from mininet.wifi.wmediumdConnector import interference


def topology():

    "Create a network."
    net = Mininet_wifi(controller=Controller, switch=OVSKernelSwitch,
                       link=wmediumd, wmediumd_mode=interference

    ncars = 10

    c1 = net.addController( 'c1', controller=RemoteController, ip='127.0.0.1', port=6633 )

    print("*** Creating nodes")
    cars = []
    stas = []
    for idx in range(0, ncars):
        cars.append(idx)
        stas.append(idx)

    # print("*** Creating nodes\n")
    # cars = []
    # for x in range(0, 19):
    #     cars.append(x)
    # for x in range(0, 19):
    #     cars[x] = net.addCar('car%s' % (x + 1), wlans=1,
    #                          ip='200.0.10.11%s/8'% (x + 1))

    # for idx in range(0, ncars):
    cars[0] = net.addCar('car0', wlans=1, range='30', ip='200.0.10.110/8', mac='00:00:00:00:00:01', mode='b', position='25,125,0')
    cars[1] = net.addCar('car1', wlans=1, range='30', ip='200.0.10.111/8', mac='00:00:00:00:00:02', mode='b', position='30,125,0')
    cars[2] = net.addCar('car2', wlans=1, range='30', ip='200.0.10.112/8', mac='00:00:00:00:00:03', mode='b', position='35,125,0')
    cars[3] = net.addCar('car3', wlans=1, range='30', ip='200.0.10.113/8', mac='00:00:00:00:00:04', mode='b', position='45,125,0')
    cars[4] = net.addCar('car4', wlans=1, range='30', ip='200.0.10.114/8', mac='00:00:00:00:00:05', mode='b', position='50,125,0')
    cars[5] = net.addCar('car5', wlans=1, range='30', ip='200.0.10.115/8', mac='00:00:00:00:00:06', mode='b', position='55,125,0')
    cars[6] = net.addCar('car6', wlans=1, range='30', ip='200.0.10.116/8', mac='00:00:00:00:00:07', mode='b', position='65,125,0')
    cars[7] = net.addCar('car7', wlans=1, range='30', ip='200.0.10.117/8', mac='00:00:00:00:00:08', mode='b', position='75,125,0')
    cars[8] = net.addCar('car8', wlans=1, range='30', ip='200.0.10.118/8', mac='00:00:00:00:00:09', mode='b', position='80,125,0')
    cars[9] = net.addCar('car9', wlans=1, range='30', ip='200.0.10.119/8', mac='00:00:00:00:00:10', mode='b', position='95,125,0')
    # cars[10] = net.addCar('car10', wlans=1, range='30', ip='200.0.10.120/8', mac='00:00:00:00:00:11', mode='b', position='50,125,0')
    # cars[11] = net.addCar('car11', wlans=1, range='30', ip='200.0.10.121/8', mac='00:00:00:00:00:12', mode='b', position='55,125,0')
    # cars[12] = net.addCar('car12', wlans=1, range='30', ip='200.0.10.122/8', mac='00:00:00:00:00:13', mode='b', position='25,125,0')
    # cars[13] = net.addCar('car13', wlans=1, range='30', ip='200.0.10.123/8', mac='00:00:00:00:00:14', mode='b', position='30,125,0')
    # cars[14] = net.addCar('car14', wlans=1, range='30', ip='200.0.10.124/8', mac='00:00:00:00:00:15', mode='b', position='50,125,0')
    # cars[15] = net.addCar('car15', wlans=1, range='30', ip='200.0.10.125/8', mac='00:00:00:00:00:16', mode='b', position='55,125,0')
    # cars[16] = net.addCar('car16', wlans=1, range='30', ip='200.0.10.126/8', mac='00:00:00:00:00:17', mode='b', position='25,125,0')
    # cars[17] = net.addCar('car17', wlans=1, range='30', ip='200.0.10.127/8', mac='00:00:00:00:00:18', mode='b', position='30,125,0')
    # cars[18] = net.addCar('car18', wlans=1, range='30', ip='200.0.10.128/8', mac='00:00:00:00:00:19', mode='b', position='35,125,0')
    # cars[19] = net.addCar('car19', wlans=1, range='30', ip='200.0.10.129/8', mac='00:00:00:00:00:20', mode='b', position='45,125,0')


    rsu1 = net.addAccessPoint('rsu1', ssid='rsu1', dpid='6', mode='g', channel='11',range='60', position='50,140,0', protocols='OpenFlow13')
    rsu2 = net.addAccessPoint('rsu2', ssid='rsu2', dpid='7', mode='g', channel='11', range='60', position='150,140,0', protocols='OpenFlow13')
    rsu3 = net.addAccessPoint('rsu3', ssid='rsu3', dpid='8', mode='g', channel='11', range='60', position='250,140,0', protocols='OpenFlow13')
   
    sw1 = net.addSwitch ('sw1', dpid='9', protocols='OpenFlow13')
    sw2 = net.addSwitch ('sw2', dpid='10', protocols='OpenFlow13')

    server_s = net.addHost ('server_s', ip='200.0.10.2/8')
    server_e = net.addHost ('server_e', ip='200.0.10.3/8')
    server_e2 = net.addHost ('server_e2', ip='200.0.10.4/8')
    server_g = net.addHost ('server_g', ip='200.0.10.5/8')
    
    server_s.plot(position='210,190,0')
    server_e.plot(position='210,220,0')
    server_e2.plot(position='210,240,0')
    server_g.plot(position='210,260,0')

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
    net.addLink(server_g, sw2)
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
    net.plotGraph(max_x=400, max_y=400)

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

    server_s.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    server_e.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')
    server_e2.cmd('iptables -I OUTPUT -p icmp --icmp-type destination-unreachable -j DROP')

    
    os.system('ovs-vsctl --all destroy QoS; ovs-vsctl --all destroy Queue')

    os.system('ovs-vsctl set-manager ptcp:6632')

    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000006/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000007/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000008/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000009/ovsdb_addr')
    os.system('curl -X PUT -d \'"tcp:127.0.0.1:6632"\' http://localhost:8080/v1.0/conf/switches/0000000000000010/ovsdb_addr')


    print( "*** Shutting ports" )
    #time.sleep(3)


    #Filtra trafego nas portas entre switches
    os.system('curl -X POST -d \'{ "dpid": 6, "cookie": 0, "cookie_mask": 1, "table_id": 1, "priority": 1, "flags": 2, "match":{ "in_port":2}, "actions":[{ "type":"CLEAR_ACTIONS"}]}\' http://localhost:8080/stats/flowentry/add')
    os.system('curl -X POST -d \'{ "dpid": 7, "cookie": 0, "cookie_mask": 1, "table_id": 1, "priority": 1, "flags": 2, "match":{ "in_port":2}, "actions":[{ "type":"CLEAR_ACTIONS"}]}\' http://localhost:8080/stats/flowentry/add')
    os.system('curl -X POST -d \'{ "dpid": 7, "cookie": 0, "cookie_mask": 1, "table_id": 1, "priority": 1, "flags": 2, "match":{ "in_port":3}, "actions":[{ "type":"CLEAR_ACTIONS"}]}\' http://localhost:8080/stats/flowentry/add')
    os.system('curl -X POST -d \'{ "dpid": 8, "cookie": 0, "cookie_mask": 1, "table_id": 1, "priority": 1, "flags": 2, "match":{ "in_port":2}, "actions":[{ "type":"CLEAR_ACTIONS"}]}\' http://localhost:8080/stats/flowentry/add')

    print("*** Moving nodes")

    cars[0].setPosition('105,125,0')
    cars[1].setPosition('112,125,0')
    cars[2].setPosition('119,125,0')
    cars[3].setPosition('126,125,0')
    cars[4].setPosition('133,125,0')
    cars[5].setPosition('140,125,0')


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