#!/bin/bash

# map domain names to the IP address 192.168.56.110
# this allows the local system to resolve these domain names 
# to the given IP address even if there is no DNS server providing the resolution
HOST="192.168.56.110"
HOST_PATH="/etc/hosts"

echo "$HOST app1.com" | sudo tee -a "$HOST_PATH"
echo "$HOST app2.com" | sudo tee -a "$HOST_PATH"
echo "$HOST app3.com" | sudo tee -a "$HOST_PATH"
