# Runbook: High CPU or Memory Usage

## Description
Pods or nodes are experiencing unusually high resource usage.

## Investigation

Check resource usage:
kubectl top pods
kubectl top nodes

Inspect pod configuration:
kubectl describe pod <pod-name>

## Common Causes
- Resource limits too low
- Memory leaks
- Inefficient application code

## Resolution
1. Adjust resource limits.
2. Scale deployment if necessary.
3. Investigate application performance issues.