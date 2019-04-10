#!/bin/bash

if [ "$1" == "" ]

then
  echo "Usage:     pingsweep.sh [network] [starting-IP] [ending-IP]"
  echo "Example: pingsweep.sh 192.168.29 5 10"

else
  tcpdump -e icmp[icmptype] == 8 -w ~/home/pingsweep.pcap & #writes icmp traffic to a file
  sleep 2 #gives tcpdump time to initialize

  for x in `seq $2 $3`; do #loop based on given ip range
    ping -c 1 $1.$x | grep "64 bytes" | cut -d " " -f4 | sed 's/.$//' #pings given ip address range and outputs online hosts
  done

  sleep 2 #gives tcpdump time to write
  pid=$(ps -e | pgrep tcpdump) #locates the process id of tcpdump
  kill -2 $pid #shuts down tcpdump
fi
