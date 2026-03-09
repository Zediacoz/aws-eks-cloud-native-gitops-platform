# Runbook: Terraform Destroy Failure -- EKS Security Group Dependency

## Description

When destroying the AWS EKS infrastructure using Terraform, the
operation may fail due to security group dependency violations between
the EKS cluster security group and the node group security group

This can prevent Terraform from deleting security groups even after the
EKS cluster or node groups are scheduled for destruction.

## Symptoms

Terraform destroy fails with errors similar to:

    DependencyViolation: resource has a dependent object
       Error deleting security group

Terraform may repeatedly attempt to delete the security group but fail
due to existing ingress rules referencing another security group

## Root Cause

Amazon EKS automatically creates and manages security group rules
between:

-   EKS Cluster Security Group
-   Node Group Security Group

During cluster deletion, ingress rules referencing the node security
group may remain, creating a dependency that prevents Terraform from
deleting the security group.

Example dependency:

    EKS Cluster Security Group
      - Ingress rule referencing Node Security Group

AWS will not allow deletion until this dependency is removed.

## Investigation

Identify the cluster security group:

    aws ec2 describe-security-groups

Or inspect via the AWS Console:

    EC2 > Security Groups

Look for rules similar to:

    Type: All traffic
    Source: sg-nodegroup

Check if the cluster security group still has ingress rules referencing
the node group security group.

## Resolution

Remove the dependency manually.

1.  Open AWS Console
2.  Navigate to:

    EC2 > Security Groups

3.  Locate the EKS cluster security group
4.  Edit **Inbound Rules**
5.  Remove the rule referencing the node security group

Example:

    Source: sg-nodegroup

6.  Save the changes.

## Recovery

After removing the rule, run Terraform destroy again:

    terraform destroy

Terraform should now successfully delete the remaining security groups
and complete the infrastructure teardown

## Prevention

Ensure the following order when destroying EKS infrastructure:

1.  Delete EKS node groups
2.  Destroy EKS cluster
3.  Remove remaining infrastructure

Example:

    terraform destroy -target=aws_eks_node_group.<name>
    terraform destroy

This helps minimize dependency conflicts during teardown
