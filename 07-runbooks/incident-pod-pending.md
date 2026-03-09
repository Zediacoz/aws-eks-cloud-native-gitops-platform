# Runbook: Kubernetes Pod Pending (Scheduling Failure)

## Description
Pods remain in Pending state when Kubernetes cannot schedule them onto nodes.

## Investigation

Check pod details:
kubectl describe pod <pod-name>

Check nodes:
kubectl get nodes

Inspect node capacity:
kubectl describe node <node-name>

## Common Causes
- Insufficient CPU or memory
- Node taints preventing scheduling
- Pod density limits reached
- Resource requests too high

## Resolution
1. Verify node capacity.
2. Adjust resource requests if needed.
3. Add additional nodes or scale node group.