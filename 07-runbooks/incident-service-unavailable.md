# Runbook: Kubernetes Service Unavailable

## Description
Application is not reachable through its Kubernetes service.

## Investigation

Check pods:
kubectl get pods

Check services:
kubectl get svc

Check endpoints:
kubectl get endpoints

Test connectivity:
kubectl port-forward svc/<service-name> 8080:80

## Common Causes
- Pods not running
- Incorrect service selector
- Application listening on wrong port

## Resolution
1. Ensure pods are healthy.
2. Confirm service selectors match pod labels.
3. Verify container port configuration.