#!/bin/bash

echo -e "\033[1;3;34m--- Server script starting ---\033[0m"

# Install K3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface eth1" K3S_KUBECONFIG_MODE="644" sh -

# Wait until K3s is ready
while ! kubectl get nodes > /dev/null 2>&1; do
    echo "Waiting for K3s to start..."
    sleep 5
done

# Apply Kubernetes manifests
kubectl apply -n kube-system -f /vagrant/app1.yaml --validate=false
kubectl apply -n kube-system -f /vagrant/app2.yaml --validate=false
kubectl apply -n kube-system -f /vagrant/app3.yaml --validate=false
kubectl apply -n kube-system -f /vagrant/ingress.yaml --validate=false

echo -e "\033[1;3;34m--- Server installation complete on pbureeraS ---\033[0m"
