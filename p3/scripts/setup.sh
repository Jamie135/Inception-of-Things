#!/bin/sh

echo "\033[1;3;34m--- Updating system ---\033[0m"

sudo apt update

echo "\033[1;3;34m--- Downloading K3s ---\033[0m"

if ! command -v k3s &> /dev/null; then
    curl -sfL https://get.k3s.io | sh -
    mkdir -p $HOME/.kube
    sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
    export KUBECONFIG=$HOME/.kube/config
else
    echo "K3s is already installed"
fi

echo "\033[1;3;34m--- Installing Docker ---\033[0m"

if ! command -v docker &> /dev/null; then
    # Add Docker's official GPG key:
    sudo apt-get update
    sudo apt-get install ca-certificates curl
    sudo install -m 0755 -d /etc/apt/keyrings
    sudo curl -fsSL https://download.docker.com/linux/debian/gpg -o /etc/apt/keyrings/docker.asc
    sudo chmod a+r /etc/apt/keyrings/docker.asc
    
    # Add the repository to Apt sources:
    echo \
    "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/debian \
    $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
    sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt-get update
    sudo usermod -aG docker ${USER}

    sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin
else
    echo "Docker is already installed"
fi

echo "\033[1;3;34m--- Installing kubectl ---\033[0m"

if ! command -v kubectl &> /dev/null; then
    KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
    curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
else
    echo "kubectl is already installed"
fi

echo "\033[1;3;34m--- Installing K3d ---\033[0m"

if ! command -v k3d &> /dev/null; then
    curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
else
    echo "K3d is already installed"
fi

curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd
rm argocd-linux-amd64

echo "\033[1;3;34m--- Setup complete ---\033[0m"
