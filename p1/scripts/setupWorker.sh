#!/bin/bash

echo -e "\033[1;3;33m--- Server Worker script starting ---\033[0m"
echo -e "\033[1;32m--- Installing K3s ---\033[0m"

curl -sfL https://get.k3s.io | K3S_URL=https://192.168.56.110:6443 \
    K3S_KUBECONFIG_MODE="644" \
	K3S_TOKEN="/vagrant/node-token" \
	INSTALL_K3S_EXEC="--flannel-iface=eth1" \
	sh -
    sleep 10

echo "\033[1;3;33m--- K3s agent installation complete on pbureeraSW ---\033[0m"
