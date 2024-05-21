set ns [new Simulator]

set tf [open dsr.tr w]
$ns trace-all $tf

set topo [new Topography]
$topo load_flatgrid 1500 1500 

set nf [open dsr.nam w]
$ns namtrace-all-wireless $nf 1500 1500

# the adhoc routing can be changed to DSDV/AODV/DSR
$ns node-config -adhocRouting DSR \
 -llType LL \
 -macType Mac/802_11 \
 -ifqType CMUPriQueue \
-ifqLen 50 \
-phyType Phy/WirelessPhy \
-channelType Channel/WirelessChannel \
-propType Propagation/TwoRayGround \
 -antType Antenna/OmniAntenna \
-topoInstance $topo \
-agentTrace ON \
-routerTrace ON 

set val(nn) 50;

create-god $val(nn)

for {set i 1} {$i <= $val(nn)} {incr i} {
set n($i) [$ns node] 
$n($i) random-motion 1
$n($i) color red 
}

for {set i 1} {$i <= $val(nn)} {incr i} { 
$n($i) set X_ [expr rand()*500] 
$n($i) set Y_ [expr rand()*500] 
$n($i) set Z_ 0 
$n($i) label "$i"
}

$ns at 0.5 "$n(1) setdest 100 200 100"
$ns at 0.5 "$n(2) setdest 100 300 100"
$ns at 0.5 "$n(3) setdest 100 400 100"
$ns at 0.5 "$n(4) setdest 100 500 100"
$ns at 0.5 "$n(5) setdest 200 100 100"
$ns at 0.5 "$n(6) setdest 200 200 100"
$ns at 0.5 "$n(7) setdest 200 300 100"
$ns at 0.5 "$n(8) setdest 200 400 100"
$ns at 0.5 "$n(9) setdest 200 500 100"
$ns at 1.5 "$n(10) setdest 300 100 100"
$ns at 1.5 "$n(11) setdest 300 200 100"
$ns at 1.5 "$n(12) setdest 300 300 100"
$ns at 1.5 "$n(13) setdest 300 400 100"
$ns at 1.5 "$n(14) setdest 300 500 100"
$ns at 1.5 "$n(15) setdest 400 100 100"
$ns at 1.5 "$n(16) setdest 400 200 100"
$ns at 1.5 "$n(17) setdest 400 300 100"
$ns at 1.5 "$n(18) setdest 400 400 100"
$ns at 1.5 "$n(19) setdest 400 500 100"
$ns at 2.5 "$n(20) setdest 500 100 100"
$ns at 2.5 "$n(21) setdest 500 200 100"
$ns at 2.5 "$n(22) setdest 500 300 100"
$ns at 2.5 "$n(23) setdest 500 400 100"
$ns at 2.5 "$n(24) setdest 500 500 100"
$ns at 2.5 "$n(25) setdest 600 100 100"
$ns at 2.5 "$n(26) setdest 600 200 100"
$ns at 2.5 "$n(27) setdest 600 300 100"
$ns at 2.5 "$n(28) setdest 600 400 100"
$ns at 2.5 "$n(29) setdest 600 500 100"
$ns at 3.5 "$n(30) setdest 700 100 100"
$ns at 3.5 "$n(31) setdest 700 200 100"
$ns at 3.5 "$n(32) setdest 700 300 100"
$ns at 3.5 "$n(33) setdest 700 400 100"
$ns at 3.5 "$n(34) setdest 700 500 100"
$ns at 3.5 "$n(35) setdest 800 100 100"
$ns at 3.5 "$n(36) setdest 800 200 100"
$ns at 3.5 "$n(37) setdest 800 300 100"
$ns at 3.5 "$n(38) setdest 800 400 100"
$ns at 3.5 "$n(39) setdest 800 500 100"
$ns at 4.5 "$n(40) setdest 900 100 100"
$ns at 4.5 "$n(41) setdest 900 200 100"
$ns at 4.5 "$n(42) setdest 900 300 100"
$ns at 4.5 "$n(43) setdest 900 400 100"
$ns at 4.5 "$n(44) setdest 900 500 100"
$ns at 4.5 "$n(45) setdest 1000 100 100"
$ns at 4.5 "$n(46) setdest 1000 200 100"
$ns at 4.5 "$n(47) setdest 1000 300 100"
$ns at 4.5 "$n(48) setdest 1000 400 100"
$ns at 4.5 "$n(49) setdest 1000 500 100"

$n($val(nn)) label "destination"
$ns at 0.5 "$n($val(nn)) setdest 100 100 500"

for {set i 1} {$i <= $val(nn)-1} {incr i} {
set tcp($i) [new Agent/TCP]
$ns attach-agent $n($i) $tcp($i)
$tcp($i) set packetSize_ 1000
set ftp($i) [new Application/FTP]
$ftp($i) attach-agent $tcp($i)
}

set sink [new Agent/TCPSink]
$ns attach-agent $n($val(nn)) $sink

for {set i 1} {$i <= $val(nn)-1} {incr i} {
$ns connect $tcp($i) $sink
$ns at 5 "$ftp($i) start"
}

proc finish {} {
global ns nf tf
$ns flush-trace
exec nam dsr.nam &
close $tf
exit 0
}

$ns at 80 "finish"
$ns run
