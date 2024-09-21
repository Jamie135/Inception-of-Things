# Kubernetes Introduction with k3s and k3d

## Key Concepts
- k3s
- k3d
- Ingress
- CI/CD
- Vagrant
- ArgoCD
- Helm

## Overview of Kubernetes
Kubernetes is an open-source platform designed to automate the deployment, scaling, and operation of application containers.

### Core Components
- **API Server**: The main management point of the cluster.
- **etcd**: A consistent and highly-available key-value store used for all cluster data.
- **Scheduler**: Distributes workloads across nodes.
- **Controller Manager**: Manages various controllers to ensure the cluster's desired state matches the actual state.
- **Kubelet**: Runs on each node and ensures containers are running.
- **Kube-Proxy**: Handles network routing and rules.

### kubectl
A command-line interface for interacting with the Kubernetes API.

### Node Types
- **Master Node**: Manages the cluster.
- **Worker Node**: Runs application workloads.

### Cluster
A collection of nodes managed by Kubernetes.

### Pods
The smallest deployable units in Kubernetes, consisting of one or more containers.

### Service
Defines a logical set of Pods and a policy for accessing them.

### Ingress
Manages external access to services within a cluster.

### k3s
A lightweight Kubernetes distribution.

### k3d
Runs k3s clusters inside Docker containers for easy local development and testing.

### Deployment
Manages the desired state of application Pods, including updates and scaling.

### Helm
A package manager for Kubernetes, simplifying application deployment and management.

## Part 1: Setting Up the Cluster
- Use Vagrant to create two virtual machines.
- Install k3s on both machines.
- Configure the cluster with:
  - One master node
  - One worker node

## Part 2: Application Deployment
- Deploy three applications using `kubectl`.
- Set up Ingress for external access.

## Part 3: CI/CD with ArgoCD
- Configure ArgoCD for automatic application deployment on code changes.

## Bonus: Local GitLab for CI/CD
- Deploy a local GitLab instance.
- Integrate GitLab with ArgoCD.

## Resources
- [Subject](./static/inception%20of%20things.pdf)
- [Kubernetes Video](https://www.youtube.com/watch?v=X48VuDVv0do)
- [ArgoCD Tutorial](https://www.youtube.com/watch?v=MeU5_k9ssrs&t=1802s)
- [cert-manager Automation](https://www.youtube.com/watch?v=D7ijCjE31GA)