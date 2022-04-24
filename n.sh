#!/bin/bash

ports=(30 20 22)
ip=127.0.0.1
for i in "${ports[@]}"
do 
echo 'Trying to connect to port ' $ip":"$ports
telnet $ip $ports << EOF
close
EOF
done 

