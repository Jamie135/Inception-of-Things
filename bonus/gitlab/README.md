# Gitlab Setup

This folder contains the necessary Kubernetes manifests to set up a Gitlab instance within the K3s cluster.

## Prerequisites

- Kubernetes cluster (K3s or similar)
- Ingress controller (e.g., Nginx Ingress Controller)

## Instructions

1. Apply the Gitlab namespace, deployment, service, and ingress configurations:

kubectl apply -f namespace.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f ingress.yaml


2. Wait for the Gitlab pod to become ready:

kubectl wait --namespace gitlab --for=condition=ready pod --selector=app=gitlab --timeout=300s


3. Access the Gitlab web interface:

- The Gitlab instance will be accessible at the hostname specified in the `ingress.yaml` file (e.g., `http://gitlab.example.com`).
- Use the default Gitlab administrator credentials (username: `root`, password: `password`) to log in.

4. (Optional) Update the Gitlab administrator password:

- After logging in, you can update the Gitlab administrator password by following the official Gitlab documentation.

## Configuration Files

- `namespace.yaml`: Defines the `gitlab` namespace.
- `deployment.yaml`: Defines the Gitlab deployment.
- `service.yaml`: Defines the Gitlab service.
- `ingress.yaml`: Defines the Ingress resource for the Gitlab instance.

## Troubleshooting

- If you encounter any issues with the Gitlab setup, check the logs of the Gitlab pod using the following command:

kubectl logs -n gitlab -l app=gitlab


- Ensure that the Ingress controller is correctly configured and able to route traffic to the Gitlab service.

## Next Steps

After setting up the Gitlab instance, proceed with the instructions in the `argocd-integration` folder to integrate Gitlab with Argo CD.