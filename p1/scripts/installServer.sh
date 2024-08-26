#!/bin/bash

# Update the package list
sudo apt-get update -y

# Install curl
sudo apt-get install -y curl

# Install K3s in server mode
curl -sfL https://get.k3s.io | sh -

# Enable K3s service to start on boot
sudo systemctl enable k3s

# Output K3s server token to a file for worker node to join
sudo cat /var/lib/rancher/k3s/server/node-token > /vagrant/node-token

# Install kubectl
sudo apt-get install -y kubectl

# Export KUBECONFIG for current session
export KUBECONFIG=/etc/rancher/k3s/k3s.yaml
echo "export KUBECONFIG=/etc/rancher/k3s/k3s.yaml" >> ~/.bashrc

# Output message indicating successful installation
echo "K3s server installation complete on pbureeraS"
