#!/bin/bash

echo 'Forwarding port 80 to 8080...'

CMD='iptables -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to-ports 8080'

sudo apt-get update
sudo apt-get install -y iptables
sudo sed -i "s/^exit 0$/$CMD\\nexit 0/g" /etc/rc.local
sudo modprobe ip_tables
sudo bash -c 'echo ip_tables >> /etc/modules'
sudo /etc/rc.local

