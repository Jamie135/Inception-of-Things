#!/bin/bash

HOST="192.168.56.110"
HOST_PATH="/etc/hosts"

echo "$HOST app1.com" | sudo tee -a "$HOST_PATH"
echo "$HOST app2.com" | sudo tee -a "$HOST_PATH"
echo "$HOST app3.com" | sudo tee -a "$HOST_PATH"
