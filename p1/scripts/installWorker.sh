#!/bin/bash

# Update the package list
sudo apt-get update -y

# Install curl
sudo apt-get install -y curl

# Read the K3s server token from the shared directory
K3S_TOKEN=$(cat /vagrant/node-token)

# Define the K3s server URL
K3S_URL="https://192.168.56.110:6443"

# Install K3s in agent mode
curl -sfL https://get.k3s.io | K3S_URL=${K3S_URL} K3S_TOKEN=${K3S_TOKEN} sh -

# Enable K3s service to start on boot
sudo systemctl enable k3s-agent

# Output message indicating successful installation
echo "K3s agent installation complete on pbureeraSW"
