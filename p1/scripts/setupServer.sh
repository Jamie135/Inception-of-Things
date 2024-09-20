#!/bin/bash

echo -e "\033[1;3;34m--- Server script starting ---\033[0m"

# "--flannel-iface eth1" allows K3s to use the eth1 network interface,
# which is critical for networking between the virtual machines on the private network
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface eth1" K3S_KUBECONFIG_MODE="644" sh -

while [ ! -e /var/lib/rancher/k3s/server/node-token ]; do
    sleep 2
done

sudo cp /var/lib/rancher/k3s/server/node-token /vagrant
sudo cp /etc/rancher/k3s/k3s.yaml /vagrant/

echo -e "\033[1;3;34m--- Server installation complete on pbureeraS ---\033[0m"
