#!/bin/bash

echo -e "\033[1;3;34m--- Server Worker script starting ---\033[0m"

apk update && apk add curl && apk add net-tools

ip addr add 192.168.56.111/24 dev eth1
ip link set eth1 up

echo -e "\033[1;32m--- Installing K3s ---\033[0m"

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="agent --write-kubeconfig-mode=644 --node-ip=192.168.56.111 --flannel-iface=eth1 --server=https://192.168.56.110:6443 --token-file=/vagrant/node-token" sh -
sleep 10

echo -e "\033[1;3;34m--- K3s worker installation complete on pbureeraSW ---\033[0m"
