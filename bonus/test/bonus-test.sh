#!/bin/bash

# Default paths for TLS certificate and private key
DEFAULT_TLS_CERT_PATH="./tls.crt"
DEFAULT_TLS_KEY_PATH="./tls.key"

# Ensure mandatory parts are completed
echo "Verifying mandatory parts..."
kubectl get nodes
kubectl get pods -A

# Generate self-signed TLS certificate and key
if [ ! -f "$DEFAULT_TLS_CERT_PATH" ] || [ ! -f "$DEFAULT_TLS_KEY_PATH" ]; then
  echo "Generating self-signed TLS certificate and private key..."
  openssl req -x509 -newkey rsa:4096 -keyout "$DEFAULT_TLS_KEY_PATH" -out "$DEFAULT_TLS_CERT_PATH" -days 365 -nodes -subj "/CN=gitlab.example.com"
fi

# Create the gitlab-tls secret if it doesn't exist
if ! kubectl get secret -n gitlab gitlab-tls > /dev/null 2>&1; then
  echo "Creating gitlab-tls secret..."
  kubectl create secret tls gitlab-tls --namespace gitlab --cert=$DEFAULT_TLS_CERT_PATH --key=$DEFAULT_TLS_KEY_PATH
fi

# Create the gitlab-credentials secret if it doesn't exist
if ! kubectl get secret -n argocd gitlab-credentials > /dev/null 2>&1; then
  echo "Creating gitlab-credentials secret..."
  read -p "Enter your Gitlab username: " gitlab_username
  read -sp "Enter your Gitlab password: " gitlab_password
  echo
  kubectl create secret generic gitlab-credentials -n argocd --from-literal=username=$gitlab_username --from-literal=password=$gitlab_password
fi

# Apply Gitlab configuration
echo "Applying Gitlab configuration..."
kubectl apply -f ../gitlab/namespace.yaml
kubectl apply -f ../gitlab/deployment.yaml
kubectl apply -f ../gitlab/service.yaml
kubectl apply -f ../gitlab/ingress.yaml

# Wait for Gitlab pod to be ready
echo "Waiting for Gitlab pod to be ready..."
kubectl wait --namespace gitlab --for=condition=ready pod --selector=app=gitlab --timeout=300s

# Check Gitlab web interface
echo "Accessing Gitlab web interface..."
GITLAB_URL=$(kubectl get ingress -n gitlab gitlab -o jsonpath='{.spec.rules[0].host}')
echo "Gitlab URL: https://$GITLAB_URL"
curl -I "https://$GITLAB_URL"

# Log in to Gitlab
echo "Logging in to Gitlab..."
GITLAB_ROOT_PASSWORD=$(kubectl get secret -n gitlab gitlab-root-password -o jsonpath='{.data.password}' | base64 --decode)
curl -X POST -H "Content-Type: application/json" -d "{\"username\":\"root\",\"password\":\"$GITLAB_ROOT_PASSWORD\"}" "https://$GITLAB_URL/api/v4/session"

# Create a new Gitlab project
echo "Creating a new Gitlab project..."
git clone "https://$GITLAB_URL/root/test-app.git"
cd test-app
echo "# Test App" > README.md
git add .
git commit -m "Initial commit"
git push origin master

# Apply Argo CD integration
echo "Applying Argo CD integration..."
kubectl apply -f ../argocd-integration/gitlab-repository.yaml
kubectl apply -f ../argocd-integration/argocd-application.yaml

# Verify Argo CD integration
echo "Verifying Argo CD integration..."
kubectl get pods -n argocd
kubectl get applications -n argocd
kubectl get deployment -n dev

echo "Bonus part test completed successfully!"
