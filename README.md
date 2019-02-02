# About the Application-driven framework for intelligent transportation systems

This framework uses softwar-defined networks to implement a 5G network slicing aproach to deal with the problem of how to provide a mobile infrastructure that can dinnamically meet the communication requirements of different vehicular networks applications.

This implementation uses the Mininet-wifi emulator (https://github.com/intrig-unicamp/mininet-wifi) and the Ryu controller (https://osrg.github.io/ryu/).

Before run the experiments, it is necessary configure the Ryu controller to accept OF 1.3 REST instructions, as described in https://osrg.github.io/ryu-book/en/html/rest_qos.html. 

These codes refer to an performance evaluation of the proposed framework in a scenario representing a traffic jam in a 1.5 km via, with 15 vehicles, in a time frame of 300 seconds, with four congestion levels over the time.

![](https://github.com/saraivacode/framework_its_sdn/blob/master/experiment.png)

This implementation permits to compare the results of the proposed framework with the use of two other approaches named "Qos only", that implements QoS in the network, and a "Best effort" approach.

## Implementation scripts

#### 1. The main script that builds the topology in Mininet-wifi, with mobility and general emulation parameters:
https://github.com/saraivacode/framework_its_sdn/blob/master/testef_14.py

##### testef_14.py options:

-f: Proposed framework approach   
-q: QoS only approach  
-b: Best effort approach   

All options require the script that will start applications traffic in vehicles. To use the -q option, it is necessary the database and Central Controller scripts. To use -f option, it is necessary the database, central controller and local controllers scripts. All these scripts are called by the main (testef_14.py).

#### 2. Shell script to vehicles generate traffic related to vehicular applications:
https://github.com/saraivacode/framework_its_sdn/blob/master/carcon.sh

#### 3. SQL script that implements the shared database in Mysql server:
https://github.com/saraivacode/framework_its_sdn/blob/master/initialdb.sql

#### 4. A shell script that implements the central controller application, interacting with Ryu SDN controller through its REST API to apply the general network QoS policies:
https://github.com/saraivacode/framework_its_sdn/blob/master/central_controller2.sh

#### 5. A shell script that acts on the RSUs, in the role of local controllers application, redirecting traffic and enforcing the policies defined by the central controller:
https://github.com/saraivacode/framework_its_sdn/blob/master/local_controllers.sh

#### There is also a shell code that is used to extract, from the files generated in emulation, the information necessary to compile the results:
https://github.com/saraivacode/framework_its_sdn/blob/master/tratamento_c3.sh

##### tratamento_c3.sh options:

fs: Proposed framework approach   
fq: QoS only approach  
fn: Best effort approach

## Execution

step 1: $ sudo apt-get install git  
step 2: $ git clone https://github.com/saraivacode/framework_its_sdn/
step 3: $ cd mininet-wifi   
step 4: # ryu-manager ryu.app.rest_qos ryu.app.qos_simple_switch_13 ryu.app.rest_conf_switch ryu.app.ofctl_rest
step 5: # testef_14.py --f, testef_14.py -q, and testef_14.py -b

## Results

After run the main script three times, each one with one of the three different approachs, follow the next steps to generate results:

, fq for the QoS only approach, fn for the Best effort approach), and after this run the following R scripts to generate the graphs:


step 1: #tratamento_c3.sh fs, tratamento_c3.sh fq, tratamento_c3.sh fn
step 2: run the followng R scripts:

1 - PDR results
https://github.com/saraivacode/framework_its_sdn/blob/master/comb_pdr.R

2 - RTT results (ECDF)
https://github.com/saraivacode/framework_its_sdn/blob/master/comb_delay.R

3 - Throughput and RTT over time results 
https://github.com/saraivacode/framework_its_sdn/blob/master/comb_geral.R
