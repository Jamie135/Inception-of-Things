#!/bin/bash

echo -e "\033[1;3;34m--- Creating bonus-cluster ---\033[0m"

if k3d cluster list | grep -q 'bonus-cluster'; then
    k3d cluster delete bonus-cluster
fi
k3d cluster create bonus-cluster --port "8888:31728@server:0"

echo -e "\033[1;3;34m--- Creating argocd and dev namespaces ---\033[0m"

kubectl create namespace argocd
kubectl create namespace dev
kubectl create namespace gitlab

echo -e "\033[1;3;34m--- Installing ArgoCD ---\033[0m"
# wait until argocd pods are created and running
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml
until kubectl -n argocd get pod -l app.kubernetes.io/name=argocd-server -o jsonpath="{.items[0].status.phase}" 2>/dev/null | grep -q "Running"; do
  echo "Waiting for ArgoCD server pod to be ready..."
  sleep 5
done

echo -e "\033[1;3;34m--- Set polling interval to 1 minute ---\033[0m"
# allow argocd to update the synchronization every minute 
kubectl -n argocd patch configmap argocd-cm -p '{"data": {"repository.pollingInterval": "1m"}}'
# after applying the patch, it deletes and recreates the ArgoCD server pod to apply the configuration changes
kubectl -n argocd delete pod -l app.kubernetes.io/name=argocd-server
kubectl -n argocd wait --for=condition=ready pod -l app.kubernetes.io/name=argocd-server --timeout=300s

echo -e "\033[1;3;34m--- Updating Helm ---\033[0m"

helm repo add gitlab https://charts.gitlab.io/
helm repo update

# # echo -e "\033[1;3;34m--- ArgoCD Login ---\033[0m"
# # nohup allows a process to continue running in the background even if the user logs out or the terminal is closed
# # forwards port 8080 on the local machine (localhost) to port 443 on the ArgoCD server service
# nohup kubectl port-forward svc/argocd-server -n argocd 9393:443 >/dev/null 2>&1 &
# ARGO_PWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
# echo "Username: admin"
# echo "Password: $ARGO_PWD"
# # argocd login localhost:9393 --username admin --password $ARGO_PWD --insecure
# # argocd account update-password --current-password $ARGO_PWD --new-password admin123
# # argocd repo add https://github.com/Jamie135/IoT-pbureera --insecure-skip-server-verification --server localhost:9393
# # kubectl patch configmap argocd-cm -n argocd --type merge -p '{"data":{"repositories":"- url: https://github.com/Jamie135/IoT-pbureera\n insecure: true\n"}}'

# echo -e "\033[1;3;34m--- Applying ArgoCD app configuration ---\033[0m"

# kubectl apply -f ./confs/argocd-app.yaml

# nohup bash -c 'while true; do kubectl port-forward svc/wil-playground -n dev 8888:8888; sleep 5; done' > /dev/null 2>&1 &
