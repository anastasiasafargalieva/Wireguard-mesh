#!/usr/bin/env bash

## Traffic going to the internet
route add default gw 172.30.30.1


## Save the iptables rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6

