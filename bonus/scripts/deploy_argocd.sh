#!/bin/bash

echo -e "\033[1;3;34m--- ArgoCD Login ---\033[0m"
# nohup allows a process to continue running in the background even if the user logs out or the terminal is closed
# forwards port 8080 on the local machine (localhost) to port 443 on the ArgoCD server service
nohup kubectl port-forward svc/argocd-server -n argocd 9393:443 >/dev/null 2>&1 &
ARGO_PWD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
echo "Argocd Username: admin"
echo "Argocd Password: $ARGO_PWD"
# argocd login localhost:9393 --username admin --password $ARGO_PWD --insecure
# argocd account update-password --current-password $ARGO_PWD --new-password admin123
# argocd repo add https://github.com/Jamie135/IoT-pbureera --insecure-skip-server-verification --server localhost:9393
# kubectl patch configmap argocd-cm -n argocd --type merge -p '{"data":{"repositories":"- url: https://github.com/Jamie135/IoT-pbureera\n insecure: true\n"}}'

echo -e "\033[1;3;34m--- Applying ArgoCD app configuration ---\033[0m"

kubectl apply -f ./confs/argocd-app.yaml

nohup bash -c 'while true; do kubectl port-forward svc/wil-playground -n dev 8888:8888; sleep 5; done' > /dev/null 2>&1 &
