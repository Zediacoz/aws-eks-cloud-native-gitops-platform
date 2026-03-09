# Runbook: ArgoCD Sync Failure

## Description
ArgoCD fails to synchronize application state from Git repository.

## Investigation

Check ArgoCD pods:
kubectl get pods -n argocd

List applications:
argocd app list

Inspect application:
argocd app get <app-name>

## Common Causes
- Invalid Kubernetes manifest
- Repository access issues
- Merge conflicts

## Resolution
1. Validate manifests in repository.
2. Ensure repository credentials are correct.
3. Trigger manual sync if required.