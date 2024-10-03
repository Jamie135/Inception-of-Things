#!/bin/sh

echo -e "\033[1;3;34m--- Updating system ---\033[0m"

sudo apt update

echo -e "\033[1;3;34m--- Downloading K3s ---\033[0m"

if ! command -v k3s &> /dev/null; then
    curl -sfL https://get.k3s.io | sh -
    mkdir -p $HOME/.kube
    sudo cp /etc/rancher/k3s/k3s.yaml $HOME/.kube/config
    sudo chown $(id -u):$(id -g) $HOME/.kube/config
    export KUBECONFIG=$HOME/.kube/config
else
    echo "K3s is already installed"
fi

echo -e "\033[1;3;34m--- Installing Docker ---\033[0m"

if ! command -v docker &> /dev/null; then
    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
    echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
    sudo apt update
    sudo apt install -y docker-ce docker-ce-cli containerd.io
    sudo usermod -aG docker ${USER}
else
    echo "Docker is already installed"
fi

echo -e "\033[1;3;34m--- Installing kubectl ---\033[0m"

if ! command -v kubectl &> /dev/null; then
    KUBECTL_VERSION=$(curl -L -s https://dl.k8s.io/release/stable.txt)
    curl -LO "https://dl.k8s.io/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl"
    chmod +x ./kubectl
    sudo mv ./kubectl /usr/local/bin/kubectl
else
    echo "kubectl is already installed"
fi

echo -e "\033[1;3;34m--- Installing K3d ---\033[0m"

if ! command -v k3d &> /dev/null; then
    curl -s https://raw.githubusercontent.com/rancher/k3d/main/install.sh | bash
else
    echo "K3d is already installed"
fi

echo -e "\033[1;3;34m--- Setup complete ---\033[0m"
