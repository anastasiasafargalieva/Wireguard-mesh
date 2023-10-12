#!/usr/bin/env bash

## Traffic going to the internet
route add default gw 172.48.48.49

## Save the iptables rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

sudo apt update
sudo apt install -y wireguard python3-pip
cd /home/vagrant/overlay_manager
pip3 install requests

sudo python3 main.py $1 $2 $3


