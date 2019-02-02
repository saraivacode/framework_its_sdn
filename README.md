# Application-driven Framework for Intelligent Transportation Systems

## About this proposed solution 

This framework uses a vehicular software-defined network to implement a 5G network slicing aproach to deal with the problem of how to provide a mobile infrastructure that can dinnamically meet the communication requirements of different vehicular network ITS applications.

This implementation uses the Mininet-wifi emulator (https://github.com/intrig-unicamp/mininet-wifi) and the Ryu controller (https://osrg.github.io/ryu/).

Before run the experiments, it is necessary configure the Ryu controller to accept OF 1.3 REST instructions, as described in https://osrg.github.io/ryu-book/en/html/rest_qos.html. 

The codes here refer to a performance evaluation of the proposed framework in a scenario representing a traffic jam in a 1.5 km via, with 15 vehicles, in a 300 seconds period, with four congestion levels over the time. The vehicles are associated with four applications, each one with different network requirements. 

<img src="https://github.com/saraivacode/framework_its_sdn/blob/master/experiment2.png" width="480">

This implementation permits to compare the results of PDR, throughput and RTT obtained with the use of the proposed framework and with two other approaches named as "Qos only", that implements just QoS in the network, and a "Best effort" approach, that do not prioritize any traffic.

### Implementation scripts

#### 1. The main script that builds the topology in Mininet-wifi, with mobility and general emulation parameters:
https://github.com/saraivacode/framework_its_sdn/blob/master/testef_14.py

##### testef_14.py options:

-f: Proposed framework approach   
-q: QoS only approach  
-b: Best effort approach   

All options require the script that will start applications traffic in vehicles. To use the -q option, it is necessary the database and Central Controller scripts. To use -f option, it is necessary the database, central controller and local controllers scripts. All these scripts are called by the main (testef_14.py).

#### 2. Shell script used to generate in vehicles the traffic related to the vehicular applications:
https://github.com/saraivacode/framework_its_sdn/blob/master/carcon.sh

#### 3. SQL script that implements the shared database in Mysql server:
https://github.com/saraivacode/framework_its_sdn/blob/master/initialdb.sql

#### 4. Shell script that implements the central controller application, interacting with Ryu SDN controller through its REST API to apply the general network QoS policies:
https://github.com/saraivacode/framework_its_sdn/blob/master/central_controller2.sh

#### 5. Shell script that acts on the RSUs, in the role of local controllers application, redirecting traffic and enforcing the policies defined by the central controller:
https://github.com/saraivacode/framework_its_sdn/blob/master/local_controllers.sh

#### Codes to compile the results:

##### Shell code that is used to extract, from the files generated in emulation, the information necessary to compile the results:
https://github.com/saraivacode/framework_its_sdn/blob/master/tratamento_c3.sh

###### tratamento_c3.sh options:

fs: Proposed framework approach   
fq: QoS only approach  
fn: Best effort approach

##### R codes to generate the graphs

1 - PDR results
https://github.com/saraivacode/framework_its_sdn/blob/master/comb_pdr.R

2 - RTT results (ECDF)
https://github.com/saraivacode/framework_its_sdn/blob/master/comb_delay.R

3 - Throughput and RTT over time results 
https://github.com/saraivacode/framework_its_sdn/blob/master/comb_geral.R

### Execution example

##### step 1 (Run ryu): # ryu-manager ryu.app.rest_qos ryu.app.qos_simple_switch_13 ryu.app.rest_conf_switch ryu.app.ofctl_rest

##### step 2 (Run experiment with best effort approach): # testef_14.py -b

##### step 3 (Run experiment with QoS only approach): # testef_14.py -q

##### step 4 (Run experiment with proposed framework approach): # testef_14.py -f

##### step 5 (Adjust best effort results): # tratamento_c3.sh fn

##### step 6 (Adjust QoS only results): # tratamento_c3.sh fq

##### step 7 (Adjust proposed framework results): # tratamento_c3.sh fs

##### step 8 (Generate in R the PDR results graphs): execute in R the comb_pdr.R file

##### step 9 (Generate in R the RTT results (ECDFs) graphs): execute in R the comb_delay.R file

##### step 10 (Generate in R the Throughput and RTT over time results graphs): execute in R the comb_geral.R file

Note: steps 2 through 7 can not be run simultaneously
