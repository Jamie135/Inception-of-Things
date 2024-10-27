#!/bin/bash

echo -e "\033[1;3;34m--- Server script starting ---\033[0m"

# "--flannel-iface eth1" allows K3s to use the eth1 network interface,
# which is critical for networking between the virtual machines on the private network
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface eth1" K3S_KUBECONFIG_MODE="644" sh -

# wait for the node-token file to be created
while [ ! -e /var/lib/rancher/k3s/server/node-token ]; do
    sleep 2
done

# when installing k3s, key files such as node token and config files are created
# they are critical for securely connecting additional nodes (workers) to the server
sudo cp /var/lib/rancher/k3s/server/node-token /vagrant
sudo cp /etc/rancher/k3s/k3s.yaml /vagrant/

echo -e "\033[1;3;34m--- Server installation complete on pbureeraS ---\033[0m"
