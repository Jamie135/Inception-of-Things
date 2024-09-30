echo -e "\033[1;3;34m--- Deploying ArgoCD ---\033[0m"

k3d cluster create p3 --port "8888:31728@server:0"

kubectl create namespace argocd
kubectl create namespace dev
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

kubectl apply -f ./confs/argocd-app.yaml

echo -e "\033[1;3;34m--- Namespace created ---\033[0m"
