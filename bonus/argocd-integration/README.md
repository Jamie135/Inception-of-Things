# Argo CD Integration with Gitlab

This folder contains the necessary configuration to integrate the Gitlab repository with Argo CD.

## Instructions

1. Apply the Gitlab repository configuration for Argo CD:

kubectl apply -f gitlab-repository.yaml


2. Apply the Argo CD application that uses the Gitlab repository:

kubectl apply -f argocd-application.yaml


3. Verify that the Argo CD application is successfully synchronizing with the Gitlab repository.

4. You can now make changes to the application code in the Gitlab repository, and Argo CD will automatically deploy the updated version.
