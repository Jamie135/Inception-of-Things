#!/bin/sh

echo -e "\033[1;3;31m--- Uninstalling K3s ---\033[0m"

if command -v k3s &> /dev/null; then
    sudo /usr/local/bin/k3s-uninstall.sh
    echo "K3s uninstalled."
else
    echo "K3s is not installed."
fi

echo -e "\033[1;3;31m--- Uninstalling Docker ---\033[0m"

if command -v docker &> /dev/null; then
    sudo apt remove -y docker-ce docker-ce-cli containerd.io
    sudo apt purge -y docker-ce docker-ce-cli containerd.io
    sudo apt autoremove -y
    sudo rm -rf /var/lib/docker
    sudo rm -rf /var/lib/containerd
    sudo rm /etc/apt/sources.list.d/docker.list
    sudo rm /etc/apt/keyrings/docker.asc
    echo "Docker and containerd uninstalled."
else
    echo "Docker is not installed."
fi

echo -e "\033[1;3;31m--- Uninstalling kubectl ---\033[0m"

if command -v kubectl &> /dev/null; then
    sudo rm /usr/local/bin/kubectl
    echo "kubectl uninstalled."
else
    echo "kubectl is not installed."
fi

echo -e "\033[1;3;31m--- Uninstalling K3d ---\033[0m"

if command -v k3d &> /dev/null; then
    k3d cluster delete my-cluster
    sudo rm /usr/local/bin/k3d
    echo "K3d uninstalled."
else
    echo "K3d is not installed."
fi

echo -e "\033[1;3;31m--- Cleanup complete ---\033[0m"
