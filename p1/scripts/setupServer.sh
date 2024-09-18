#!/bin/bash

echo -e "\033[1;3;34m--- Server script starting ---\033[0m"

apt-get update -y && apt-get install -y curl

echo -e "\033[1;32m--- Installing K3s ---\033[0m"

# --node-ip=$SERVER_IP: specifies the node's IP address which is set earlier in the Vagrantfile
# --flannel-iface=eth1: allows K3s to use the eth1 network interface, which is critical for networking between the virtual machines on the private network
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="server --write-kubeconfig-mode=644 --node-ip 192.168.56.110 --flannel-iface eth1" sh -s -

# wait unitl the node-token file is created
while [ ! -e /var/lib/rancher/k3s/server/node-token ]
    do
        sleep 2
    done

sudo cp /var/lib/rancher/k3s/server/node-token /vagrant/

sudo cp /etc/rancher/k3s/k3s.yaml /vagrant/

echo "\033[1;3;34m--- K3s server installation complete on pbureeraS ---\033[0m"
