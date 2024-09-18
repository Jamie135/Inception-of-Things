#!/bin/bash

echo -e "\033[1;3;34m--- Server script starting ---\033[0m"

apt-get update -y && apt-get install -y curl

echo -e "\033[1;32m--- Installing K3s ---\033[0m"


curl -sfL https://get.k3s.io | K3S_KUBECONFIG_MODE="644" \
    # --node-ip=$SERVER_IP: specifies the node's IP address which is set earlier in the Vagrantfile
    # --flannel-iface=eth1: allows K3s to use the eth1 network interface, which is critical for networking between the virtual machines on the private network
    INSTALL_K3S_EXEC="--node-ip=$SERVER_IP --flannel-iface=eth1" \
    sh -

# copies the K3s node-token (used for authenticating worker nodes to the master node)
# from the server’s directory to the /vagrant/ folder, it will allow the Worker node to access this token
sudo cp -v /var/lib/rancher/k3s/server/node-token /vagrant/

if ! grep 'kubectl get all' /home/vagrant/.bashrc; then
	echo "
  echo
  echo -e '\033[1mkubectl get node -o wide:\033[0m'
  sudo kubectl get node -o wide
  echo
  echo -e '\033[1mifconfig eth1 (ip addr | grep 'eth1:' -A 6):\033[0m'
  ip addr | grep 'eth1:' -A 6
  " >>/home/vagrant/.bashrc
fi

echo "\033[1;3;34m--- K3s server installation complete on pbureeraS ---\033[0m"
