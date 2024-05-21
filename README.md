Instructions to open-source file:
1. Open terminal in ns2
2. To create directory: Press cd name
3. To open source file :
Press gedit
<Filename>.tcl

SIMULATION SETUP

The goal of all the simulations in this project is to present a quantitative relation between network performance metrics such as packet delivery ratio, throughput and e2e delay and other varying network parameters like the number of nodes, number of connections, mobility speed and pause time. To run the simulations, we have used NS-2 version 2.35 built on Ubuntu 13.04 Linux.
To gather fair comparison results of the three protocols, identical mobility and traffic scenarios are used for each of them. Also for a better estimation of the performance metrics we ran 5 simulation for AODV, DSR and DSDV each with variation in the number of nodes in each simulation.First Simulation of each of the routing protocol was conducted using 10 nodes. Second Simulation was conducted using 20 nodes and the third using 30 nodes, fourth using 40 and fifth Simulation was conducted using 50 nodes for each of the routing protocols to compare the variation of the values of various parameters as discussed in above section.
Awk Script was written to record the data of the above simulation conducted. Awk is a scripting language used for manipulating data and generating reports. The awk command programming language requires no compiling and allows the user to use variables, numeric functions, string functions, and logical operators. We used AWK scripts to process the trace files and plot the graphs of the metrics for each protocol.
