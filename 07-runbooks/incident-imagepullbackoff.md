# Runbook: Kubernetes ImagePullBackOff

## Description
ImagePullBackOff occurs when Kubernetes cannot pull the container image.

## Investigation

Describe pod:
kubectl describe pod <pod-name>

Check events:
kubectl get events

## Common Causes
- Image does not exist in registry
- Incorrect image tag
- Authentication failure
- Network connectivity issues

## Resolution
1. Confirm image exists in registry.
2. Verify tag is correct.
3. Ensure cluster has permission to pull images.
4. Redeploy pod.