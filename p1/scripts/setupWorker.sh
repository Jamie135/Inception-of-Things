#!/bin/bash

echo -e "\033[1;3;34m--- Worker script starting ---\033[0m"

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface eth1" K3S_URL=https://192.168.56.110:6443 K3S_TOKEN=$(sudo cat /vagrant/node-token) K3S_KUBECONFIG_MODE="644" sh -

echo -e "\033[1;3;34m--- Worker installation complete on pbureeraSW ---\033[0m"
