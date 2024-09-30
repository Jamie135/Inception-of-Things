#!/bin/sh

echo -e "\033[1;3;34m--- Updating system ---\033[0m"

sudo apt update

echo -e "\033[1;3;34m--- Installing Docker ---\033[0m"

curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io || error_exit "Failed to install Docker"
sudo usermod -aG docker ${USER}
echo "Please log out and log back in to apply Docker group changes, or run 'newgrp docker'."

echo -e "\033[1;3;34m--- Installing kubectl ---\033[0m"

KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl" || error_exit "Failed to download kubectl"
chmod +x ./kubectl
sudo mv ./kubectl /usr/local/bin/kubectl

echo -e "\033[1;3;34m--- Installing K3d ---\033[0m"

curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash

echo -e "\033[1;3;34m--- Setup complete ---\033[0m"
