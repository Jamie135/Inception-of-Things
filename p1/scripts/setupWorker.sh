#!/bin/bash

echo -e "\033[1;3;34m--- Worker script starting ---\033[0m"

apt-get update && apt-get install -y curl net-tools

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --node-ip=192.168.56.111 --server=https://192.168.56.110:6443 --flannel-iface=eth1 --token-file=/vagrant/node-token" sh -

echo -e "\033[1;3;34m--- Worker installation complete on pbureeraSW ---\033[0m"
