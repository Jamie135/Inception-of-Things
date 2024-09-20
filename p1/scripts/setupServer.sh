#!/bin/bash

echo -e "\033[1;3;34m--- Server script starting ---\033[0m"

apt-get update && apt-get install -y curl net-tools

# --node-ip=$SERVER_IP: specifies the node's IP address which is set earlier in the Vagrantfile
# --flannel-iface=eth1: allows K3s to use the eth1 network interface, which is critical for networking between the virtual machines on the private network
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --node-ip=192.168.56.110 --flannel-iface=eth1 --write-kubeconfig-mode=644" sh - 
cp /var/lib/rancher/k3s/server/node-token /vagrant
cp /etc/rancher/k3s/k3s.yaml /vagrant/

echo -e "\033[1;3;34m--- Server installation complete on pbureeraS ---\033[0m"
