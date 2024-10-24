#!/bin/bash

echo -e "\033[1;3;34m--- Configuring Helm ---\033[0m"

# Download the YAML file to ensure it's available before running helm upgrade
curl -o values-minikube-minimum.yaml https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml

helm upgrade --install gitlab gitlab/gitlab \
    -n gitlab \
    -f values-minikube-minimum.yaml \
    --set global.hosts.domain=my-host.internal \
    --set global.hosts.externalIP=0.0.0.0 \
    --set global.hosts.https=false \
    --timeout 600s


# sudo helm upgrade --install gitlab gitlab/gitlab \
#     -n gitlab \
#     -f https://gitlab.com/gitlab-org/charts/gitlab/raw/master/examples/values-minikube-minimum.yaml \
#     --set global.hosts.domain=my-host.internal \
#     --set global.hosts.externalIP=0.0.0.0 \
#     --set global.hosts.https=false \
#     --timeout 600s

#waiting for webservice to be running
echo -e "\033[1;3;34m--- Waiting for webservice to be ready ---\033[0m"

kubectl wait --for=condition=ready --timeout=1200s pod -l app=webservice -n gitlab

# gitlab localhost:80 or http://my-host.internal
kubectl port-forward svc/gitlab-webservice-default -n gitlab 80:8181 >/dev/null 2>&1 &

echo -n "Gitlab Password : "
kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath="{.data.password}" | base64 --decode
echo ""
echo -n "ssh key:"
cat ~/.ssh/id_rsa.pub
echo ""

echo -e "\033[1;3;34m--- Gitlab is running on http://my-host.internal ---\033[0m"
echo -e "\033[1;3;34m--- Create a project manually and move files from https://github.com/Jamie135/IoT-pbureera to that project ---\033[0m"
