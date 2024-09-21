# Kubernetes with k3s and k3d

## Table of Contents
1. [Introduction to Kubernetes](#introduction-to-kubernetes)
   - [Core Components](#core-components)
   - [Key Concepts](#key-concepts)
2. [Exploring Lightweight Kubernetes: k3s and k3d](#exploring-lightweight-kubernetes-k3s-and-k3d)
3. [Practical Labs](#practical-labs)
   - [Lab 1: Cluster Setup](#lab-1-cluster-setup)
   - [Lab 2: Deploying Applications](#lab-2-deploying-applications)
   - [Lab 3: Implementing CI/CD with ArgoCD](#lab-3-implementing-cicd-with-argocd)
   - [Bonus Lab: Setting Up Local GitLab for CI/CD](#bonus-lab-setting-up-local-gitlab-for-cicd)
4. [Further Learning Resources](#further-learning-resources)

## Introduction to Kubernetes
Kubernetes is a powerful open-source platform that automates the management of containerized applications. It handles tasks such as deployment, scaling, operation and recovery making it easier to manage complex application environments.

### Core Components
Kubernetes is built on several core components, each playing a crucial role in the functioning of the cluster:

- **API Server**: This is the central control point for the entire Kubernetes cluster. It exposes the Kubernetes API, serving as the gateway through which all administrative tasks are performed, whether by users or internal components.
  
- **etcd**: A distributed, reliable key-value store used by Kubernetes to store all its cluster data. It is critical for maintaining the desired state of the cluster and ensuring data consistency.

- **Scheduler**: The component responsible for distributing workloads (Pods) across the various nodes in the cluster. It considers resource availability and other constraints to place Pods on the appropriate nodes.

- **Controller Manager**: This is a daemon that runs various controllers. Controllers ensure that the cluster’s actual state matches the desired state as defined by the API Server. For example, the Node Controller ensures that nodes are functioning correctly, while the ReplicaSet Controller ensures that the correct number of Pods are running.

- **Kubelet**: An agent that runs on every node in the cluster. It communicates with the API Server to receive Pod specifications and ensures that the containers described in the Pods are running and healthy.

- **Kube-Proxy**: This network proxy runs on each node in the cluster, ensuring network traffic is correctly routed to and from containers. It manages the routing rules and load balancing for service traffic.

### Key Concepts
To effectively use Kubernetes, it’s important to understand several key concepts:

- **kubectl**: This is the command-line tool used to interact with the Kubernetes cluster. With `kubectl`, you can deploy applications, inspect and manage cluster resources, and view logs.

- **Node Types**:
  - **Master Node**: The brain of the Kubernetes cluster, responsible for managing the cluster’s state and coordinating all activities. It runs the API Server, etcd, Scheduler, and Controller Manager.
  - **Woker Node**: These nodes run your application workloads. They host the containers that make up your applications and are managed by the Master Node.

- **Cluster**: A Kubernetes cluster is a collection of nodes (both master and worker) that work together to run containerized applications. The Master Node orchestrates all operations, while Worker Nodes handle the execution of the workloads.

- **Pods**: The smallest deployable unit in Kubernetes, a Pod represents a single instance of a running process in your cluster. Pods typically contain one or more containers that share the same network namespace and storage volumes.

- **Service**: A Kubernetes Service provides a stable IP address and DNS name for a set of Pods, enabling external access to them. Services abstract away the complexity of pod IP addresses and load balancing.

- **Ingress**: Ingress is a collection of rules that allow external HTTP and HTTPS access to services within a Kubernetes cluster. It acts as an entry point to the cluster’s services, providing load balancing, SSL termination, and name-based virtual hosting.

- **Deployment**: A Kubernetes Deployment automates the creation and management of Pods. It defines the desired state for your application and ensures that the right number of Pods are running at all times. Deployments are also used for rolling updates and rollbacks.

- **Helm**: Helm is a package manager for Kubernetes, akin to `apt` for Debian or `yum` for Red Hat. Helm simplifies the deployment and management of applications by packaging them as Charts, which can be easily installed, updated, and managed.

## Exploring Lightweight Kubernetes: k3s and k3d
Kubernetes can be resource-intensive, which can be a challenge for smaller environments or local development. This is where lightweight distributions like k3s and k3d come in:

- **k3s**: Developed by Rancher Labs, k3s is a lightweight, production-grade Kubernetes distribution. It is designed to be easy to install and run, especially in resource-constrained environments like IoT devices or small VMs. k3s combines many of Kubernetes' essential components into a single binary, reducing overhead and complexity.

- **k3d**: k3d allows you to run k3s clusters within Docker containers. This makes it extremely convenient for local development and testing, as you can quickly spin up and tear down clusters without the need for dedicated hardware. k3d simplifies the management of these clusters and integrates seamlessly with Docker’s networking and storage.

## Project

### Part 1: Cluster Setup
In this part, you’ll set up a basic Kubernetes cluster using k3s. This involves creating virtual machines and installing k3s:

1. **Create Virtual Machines**: Use Vagrant to provision two virtual machines that will serve as nodes in your Kubernetes cluster.
2. **Install k3s**: Install the k3s distribution on both machines. This lightweight Kubernetes will serve as the backbone of your cluster.
3. **Cluster Configuration**: Set up your cluster with one machine acting as the Master Node and the other as the Worker Node. You’ll learn how to join the Worker Node to the cluster and verify that both nodes are communicating correctly.

### Part 2: Deploying Applications
Once your cluster is up and running, you’ll deploy applications to it:

1. **Application Deployment**: Deploy three different applications using `kubectl`, exploring different deployment strategies.
2. **Ingress Configuration**: Set up Ingress resources to manage external access to your deployed applications. You’ll learn how to configure routing, handle SSL, and manage virtual hosts.

### Part 3: Implementing CI/CD with ArgoCD
Continuous Integration and Continuous Deployment (CI/CD) are essential practices for modern application development. In this lab, you’ll:

1. **Install ArgoCD**: Set up ArgoCD, a declarative GitOps continuous delivery tool for Kubernetes.
2. **Automate Deployments**: Configure ArgoCD to automatically deploy applications whenever there are changes in your code repository. This ensures that your deployments are always up-to-date with the latest changes.

### Bonus Lab: Setting Up Local GitLab for CI/CD
In this optional lab, you’ll take CI/CD a step further by setting up a local GitLab instance and integrating it with ArgoCD:

1. **Deploy GitLab**: Install and configure a local GitLab instance to manage your code repositories.
2. **Integrate with ArgoCD**: Link GitLab with ArgoCD to enable automated CI/CD pipelines. This setup will allow you to push changes to your GitLab repository and have them automatically deployed to your Kubernetes cluster.

## Useful commands

**Run Vagrantfile**
```bash
vagrant up
```
**Destroy a machine**
```bash
vagrant destroy vm_name
```
**SSH to a machine**
```bash
vagrant ssh vm_name
```
**List all nodes in the cluster**
```bash
kubectl get nodes -o wide
```
**Display eth1 configuration**
```bash
ifconfig eth1
```
**Display running applications**
```bash
kubectl get all -n kube-system
```
**Associate IP address to domain names**
```bash
echo "192.168.56.110 app1.com app2.com app3.com" | sudo tee -a /etc/hosts
```
**List all machines**
```bash
VBoxManage list vms
```
**Poweroff a machine**
```bash
VBoxManage controlvm vm_name poweroff
```
**Unregister and delete a machine**
```bash
VBoxManage unregistervm vm_name --delete
```
**Unregister and delete a machine**
```bash
VBoxManage unregistervm vm_name --delete
```
**In case some files remain**
```bash
rm -rf /home/pbureera/VirtualBox\ VMs/vm_name
```


## Further Learning Resources
To deepen your understanding of Kubernetes and related tools, here are some valuable resources:

- [Introduction to Kubernetes (PDF)](./static/inception%20of%20things.pdf): A comprehensive guide covering the basics of Kubernetes.
- [Kubernetes Video Tutorial](https://www.youtube.com/watch?v=X48VuDVv0do): A detailed video introduction to Kubernetes.
- [ArgoCD Tutorial Video](https://www.youtube.com/watch?v=MeU5_k9ssrs&t=1802s): Learn how to set up and use ArgoCD for GitOps-based continuous delivery.
- [cert-manager Automation Video](https://www.youtube.com/watch?v=D7ijCjE31GA): A tutorial on automating SSL certificate management in Kubernetes using cert-manager.
