import os
import requests 
import json
import sys
import re


def main():
    overlay_id = sys.argv[1]
    device_id = sys.argv[2]
    token = sys.argv[4]
    
    
    #response = #requests.get(f'http://meshmash.vikaa.fi:49162/devices/{device_id}/token', headers={"x-api-key" : 'F2AdF83Bd74655f206Ff53CC4CbdF300'})
    #print(response)
    #token = response.json()["token"]
    
    config = requests.get(f'http://meshmash.vikaa.fi:49162/overlays/{overlay_id}/devices/{device_id}/wgconfig?', headers={'Authorization': f'Bearer {token}'})
    final_config = re.sub(r"Peer \d+", "Peer", config.content.decode("utf-8"))
    final_config = final_config.replace(": 51820", ":5555")

    with open("sample.txt", "r") as file:
        sample_interface = file.read()

    with open("private.key", "r") as file:
        private_key = file.read()
    
    sample_interface = sample_interface.format(private_key=private_key, virtual_address=sys.argv[3])

    with open("/etc/wireguard/wg0.conf", "w") as file:
        file.write(sample_interface + "\n" +final_config)

    os.system("sudo systemctl enable wg-quick@wg0.service")
    os.system("sudo systemctl start wg-quick@wg0.service")


if __name__ == "__main__" :
    main()

