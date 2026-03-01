terraform {
  required_version = ">= 1.5.0"
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.region
}

locals {
  common_tags = merge(var.tags, {
    Project = "DevOpsPlatform"
  })
}

# Required subnet tags so Kubernetes can discover subnets for LoadBalancers later.
resource "aws_ec2_tag" "public_subnet_cluster" {
  for_each    = toset(data.terraform_remote_state.network.outputs.public_subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "shared"
}

resource "aws_ec2_tag" "public_subnet_role" {
  for_each    = toset(data.terraform_remote_state.network.outputs.public_subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/role/elb"
  value       = "1"
}

resource "aws_ec2_tag" "private_subnet_cluster" {
  for_each    = toset(data.terraform_remote_state.network.outputs.private_subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/cluster/${var.cluster_name}"
  value       = "shared"
}

resource "aws_ec2_tag" "private_subnet_role" {
  for_each    = toset(data.terraform_remote_state.network.outputs.private_subnet_ids)
  resource_id = each.value
  key         = "kubernetes.io/role/internal-elb"
  value       = "1"
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 20.0"

  cluster_name    = var.cluster_name
  cluster_version = "1.29"

  vpc_id     = data.terraform_remote_state.network.outputs.vpc_id
  subnet_ids = data.terraform_remote_state.network.outputs.private_subnet_ids

  cluster_endpoint_public_access           = true
  enable_cluster_creator_admin_permissions = true

  eks_managed_node_groups = {

  default = {
    name           = "default"
    instance_types = ["t3.micro"]

    desired_size = 3
    min_size     = 1
    max_size     = 6
  }

  monitoring = {
    name           = "monitoring"
    instance_types = ["t3.small"]

    desired_size = 1
    min_size     = 1
    max_size     = 2

    labels = {
      workload = "monitoring"
    }

    taints = {
      dedicated = {
        key    = "dedicated"
        value  = "monitoring"
        effect = "NO_SCHEDULE"
      }
    }
  }
}

  tags = local.common_tags
}