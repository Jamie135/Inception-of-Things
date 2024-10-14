#!/bin/bash

# Ensure mandatory parts are completed
echo "Verifying mandatory parts..."
kubectl get nodes
kubectl get pods -A

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
echo "Gitlab URL: http://$GITLAB_URL"
curl -I "http://$GITLAB_URL"

# Log in to Gitlab
echo "Logging in to Gitlab..."
GITLAB_PASSWORD=$(kubectl get secret -n gitlab gitlab-password -o jsonpath='{.data.password}' | base64 --decode)
echo "Gitlab root password: $GITLAB_PASSWORD"

# Create a new Gitlab project
echo "Creating a new Gitlab project..."
gitlab-runner register \
  --non-interactive \
  --url "http://$GITLAB_URL" \
  --registration-token "$(kubectl get secret -n gitlab gitlab-token -o jsonpath='{.data.token}' | base64 --decode)"
git clone "http://$GITLAB_URL/root/test-app.git"
cd test-app
echo "# Test App" > README.md
git add .
git commit -m "Initial commit"
git push origin master

# Verify Argo CD integration
echo "Verifying Argo CD integration..."
kubectl get pods -n argocd
kubectl get applications -n argocd
kubectl get deployment -n dev

echo "Bonus part test completed successfully!"