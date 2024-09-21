echo -e "\033[1;3;34m--- Server script starting ---\033[0m"

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--flannel-iface eth1" K3S_KUBECONFIG_MODE="644" sh -

sleep 10

kubectl apply -n kube-system -f /vagrant/app1.yaml --validate=false
kubectl apply -n kube-system -f /vagrant/app2.yaml --validate=false
kubectl apply -n kube-system -f /vagrant/app3.yaml --validate=false
kubectl apply -n kube-system -f /vagrant/ingress.yaml --validate=false

echo -e "\033[1;3;34m--- Server installation complete on pbureeraS ---\033[0m"
