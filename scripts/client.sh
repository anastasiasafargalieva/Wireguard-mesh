#!/usr/bin/env bash

## Traffic going to the internet
route add default gw 10.1.0.1

## Save the iptables rules
iptables-save > /etc/iptables/rules.v4
ip6tables-save > /etc/iptables/rules.v6



## Install app
cd /home/vagrant/client_app
npm install

cat << EOF > config.json
{
  "server_ip": "$1",
  "server_port": "8080",
  "log_file": "/var/log/client.log"
}
EOF

## Install wireguard manager software
sudo apt update
sudo apt install -y wireguard python3-pip
cd /home/vagrant/overlay_manager
pip3 install requests

#sudo python3 main.py $1 $2 $3
device_id = $2
contenttype_header = "Content-Type: application/json"
api_key_header="x-api-key: "${X_API_KEY}
get_token = "http://meshmash.vikaa.fi:49162/devices/{device_id}/token"
echo "Get the token"
response=$(curl -s --request GET -H "${contenttype_header}" -H "${api_key_header}" ${get_token} | jq -r '.token')
echo $response
TOKEN=$response

sudo python3 main.py $1 $2 $3 $TOKEN


