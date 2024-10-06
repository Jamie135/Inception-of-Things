#!/bin/bash

echo -e "\033[1;3;34m--- Deploying argocd and dev ---\033[0m"

if k3d cluster list | grep -q 'my-cluster'; then
    k3d cluster delete p3-cluster
fi

k3d cluster create p3-cluster --port "8888:31728@server:0"

kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
kubectl apply -f ./confs/argocd-app.yaml

echo -e "\033[1;3;34m--- Namespaces created ---\033[0m"
