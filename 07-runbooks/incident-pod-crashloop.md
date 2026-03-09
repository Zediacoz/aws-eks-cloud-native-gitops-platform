# Runbook: Kubernetes Pod CrashLoopBackOff

## Description
A pod enters CrashLoopBackOff when the container repeatedly crashes and Kubernetes restarts it.

## Investigation

Check pods:
kubectl get pods -A

Describe the pod:
kubectl describe pod <pod-name>

View previous container logs:
kubectl logs <pod-name> --previous

## Common Causes
- Application crash or runtime error
- Missing environment variables or secrets
- Dependency service unavailable
- Configuration errors

## Resolution
1. Review container logs to identify crash reason.
2. Fix configuration or application issue.
3. Redeploy application if necessary:
kubectl rollout restart deployment <deployment-name>