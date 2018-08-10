#!/usr/bin/python

'An SDN Framework to Application Driven Vehicular Ad Hoc Networks - VANETs'

import os
import random
import time

from mininet.node import RemoteController, OVSKernelSwitch
from mininet.log import setLogLevel, info
from mn_wifi.cli import CLI_wifi
from mn_wifi.net import Mininet_wifi
from mn_wifi.link import wmediumd
from mn_wifi.wmediumdConnector import interference
from mininet.link import TCLink


def topology():

    "Create a network."
    net = Mininet_wifi(controller=None, switch=OVSKernelSwitch, link=wmediumd, wmediumd_mode=interference)
    c1 = net.addController( 'c1', controller=RemoteController, ip='127.0.0.1', port=6633 )

    info("*** Creating nodes\n")
    cars = []
    for x in range(0, 20):
        cars.append(x)

    cars[0] = net.addCar('car0', wlans=1, range='50', ip='200.0.10.110/8', mac='00:00:00:00:00:01', mode='g', position='2060,975,0')
    cars[1] = net.addCar('car1', wlans=1, range='50', ip='200.0.10.111/8', mac='00:00:00:00:00:02', mode='g', position='2070,975,0')
    cars[2] = net.addCar('car2', wlans=1, range='50', ip='200.0.10.112/8', mac='00:00:00:00:00:03', mode='g', position='2080,975,0')
    cars[3] = net.addCar('car3', wlans=1, range='50', ip='200.0.10.113/8', mac='00:00:00:00:00:04', mode='g', position='2090,975,0')
    cars[4] = net.addCar('car4', wlans=1, range='50', ip='200.0.10.114/8', mac='00:00:00:00:00:05', mode='g', position='2100,975,0')
    cars[5] = net.addCar('car5', wlans=1, range='50', ip='200.0.10.115/8', mac='00:00:00:00:00:06', mode='g', position='2110,975,0')
    cars[6] = net.addCar('car6', wlans=1, range='50', ip='200.0.10.116/8', mac='00:00:00:00:00:07', mode='g', position='2095,975,0')

    cars[7] = net.addCar('car7', wlans=1, range='50', ip='200.0.10.117/8', mac='00:00:00:00:00:08', mode='g', position='1560,975,0')
    cars[8] = net.addCar('car8', wlans=1, range='50', ip='200.0.10.118/8', mac='00:00:00:00:00:09', mode='g', position='1570,975,0')
    cars[9] = net.addCar('car9', wlans=1, range='50', ip='200.0.10.119/8', mac='00:00:00:00:00:10', mode='g', position='1580,975,0')
    cars[10] = net.addCar('car10', wlans=1, range='50', ip='200.0.10.120/8', mac='00:00:00:00:00:11', mode='g', position='1590,975,0')
    cars[11] = net.addCar('car11', wlans=1, range='50', ip='200.0.10.121/8', mac='00:00:00:00:00:12', mode='g', position='1600,975,0')
    cars[12] = net.addCar('car12', wlans=1, range='50', ip='200.0.10.122/8', mac='00:00:00:00:00:13', mode='g', position='1585,975,0')

    cars[13] = net.addCar('car13', wlans=1, range='50', ip='200.0.10.123/8', mac='00:00:00:00:00:14', mode='g', position='1060,975,0')
    cars[14] = net.addCar('car14', wlans=1, range='50', ip='200.0.10.124/8', mac='00:00:00:00:00:15', mode='g', position='1070,975,0')
    cars[15] = net.addCar('car15', wlans=1, range='50', ip='200.0.10.125/8', mac='00:00:00:00:00:16', mode='g', position='1080,975,0')
    cars[16] = net.addCar('car16', wlans=1, range='50', ip='200.0.10.126/8', mac='00:00:00:00:00:17', mode='g', position='1090,975,0')
    cars[17] = net.addCar('car17', wlans=1, range='50', ip='200.0.10.127/8', mac='00:00:00:00:00:18', mode='g', position='1100,975,0')
    cars[18] = net.addCar('car18', wlans=1, range='50', ip='200.0.10.128/8', mac='00:00:00:00:00:19', mode='g', position='1110,975,0')
    cars[19] = net.addCar('car19', wlans=1, range='50', ip='200.0.10.129/8', mac='00:00:00:00:00:20', mode='g', position='1120,975,0')

    rsu1 = net.addAccessPoint('rsu1', ssid='rsu1', dpid='6', mode='g', channel='11',range='250', position='1100,1000,0', protocols='OpenFlow13')
    rsu2 = net.addAccessPoint('rsu2', ssid='rsu2', dpid='7', mode='g', channel='11', range='250', position='1600,1000,0', protocols='OpenFlow13')
    rsu3 = net.addAccessPoint('rsu3', ssid='rsu3', dpid='8', mode='g', channel='11', range='250', position='2100,1000,0', protocols='OpenFlow13')

    sw1 = net.addSwitch ('sw1', dpid='9', protocols='OpenFlow13', position='1600,1750,0')
    sw2 = net.addSwitch ('sw2', dpid='10', protocols='OpenFlow13', position='1800,1750,0')

    server_s1 = net.addHost ('server_s1', ip='200.0.10.2/8', position='1000,1150,0')
    server_s2 = net.addHost ('server_s2', ip='200.0.10.2/8', position='1500,1150,0')
    server_s3 = net.addHost ('server_s3', ip='200.0.10.2/8', position='2150,1150,0')
    server_e = net.addHost ('server_e', ip='200.0.10.3/8', position='2000,1700,0')
    server_e2 = net.addHost ('server_e2', ip='200.0.10.4/8', position='2000,1900,0')
    server_g = net.addHost ('server_g', ip='200.0.10.5/8', position='2000,2100,0')
    
    info("*** Configuring Propagation Model\n")
    net.propagationModel(model="logDistance", exp=4.5)

    info("*** Configuring wifi nodes\n")
    net.configureWifiNodes()

    info("*** Associating and Creating links\n")
    net.addLink(server_s1, rsu1, 0, 5)
    net.addLink(server_s2, rsu2, 0, 5)
    net.addLink(server_s3, rsu3, 0, 5)
    net.addLink(server_e, sw2, 0, 1)
    net.addLink(server_e2, sw2, 0, 2)
    net.addLink(server_g, sw2, 0, 3)
    link1 = net.addLink(sw1, sw2, 1, 4, cls=TCLink )
    link2 = net.addLink(rsu1, sw1, 3, 2, cls=TCLink)
    link3 = net.addLink(rsu2, sw1, 4, 3, cls=TCLink)
    link4 = net.addLink(rsu3, sw1, 3, 4, cls=TCLink)

    print( "*** Configuring links bandwidth" )
    link1.intf1.config( bw=93 )
    link2.intf1.config( bw=31 )
    link3.intf1.config( bw=31 )
    link4.intf1.config( bw=31 )

    print( "*** Ploting Graph" )
    net.plotGraph(max_x=2500, max_y=2500)

    print("*** Starting network")
    net.build()
    c1.start()
    rsu1.start([c1])
    rsu2.start([c1])
    rsu3.start([c1])
    sw1.start([c1])
    sw2.start([c1])

    print("*** Running CLI")
    CLI_wifi(net)

    print("*** Stopping network")
    net.stop()

if __name__ == '__main__':
    setLogLevel('info')
topology()