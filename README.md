# Production-Style Kubernetes Platform on AWS (Terraform + GitOps + Observability)

## Overview

This project demonstrates the design and deployment of a Kubernetes-based platform on AWS using modern DevOps practices such as Infrastructure as Code, GitOps, CI/CD, and observability.

Infrastructure is provisioned with Terraform and deploys a Kubernetes cluster on Amazon EKS. Applications are containerized with Docker, built and pushed to Amazon ECR through a GitHub Actions pipeline, and deployed to the cluster using ArgoCD following a GitOps workflow.

Monitoring is implemented using Prometheus and Grafana to provide visibility into cluster workloads and infrastructure metrics. The repository also includes operational documentation and runbooks to simulate real-world troubleshooting and incident response scenarios.

The goal of the project is to demonstrate practical DevOps engineering skills across the full platform lifecycle: infrastructure provisioning, automated container builds, GitOps-based deployments, and platform observability within a cloud-native environment.

## Architecture

<p align="center">
  <img src="docs/images/Architecture_Diagram.png" alt="Platform Architecture" width="1000">
</p>



## Technologies Used

- AWS
- Terraform
- Kubernetes (EKS)
- Docker
- ArgoCD
- Prometheus
- Grafana
- GitHub Actions

## Infrastructure Flow

1. Terraform provisions networking
2. EKS cluster is created
3. Docker image built via GitHub Actions
4. Image pushed to ECR
5. ArgoCD deploys application
6. Prometheus collects metrics
7. Grafana visualizes metrics

## CI/CD Pipeline

The project uses GitHub Actions to automate container image builds and deployment updates.

Workflow:

1. Code changes are pushed to the GitHub repository.
2. GitHub Actions builds a Docker image.
3. The image is pushed to Amazon ECR.
4. ArgoCD detects changes in the repository and synchronizes the Kubernetes cluster.
5. The application is deployed automatically to the EKS cluster.

This approach follows a GitOps model where the desired cluster state is stored in Git and continuously reconciled by ArgoCD.

## Monitoring

The project includes a monitoring stack using Prometheus and Grafana.

Prometheus collects metrics from Kubernetes components and workloads, enabling visibility into cluster health and resource usage.

Grafana connects to Prometheus as a data source and provides dashboards for visualizing system and application metrics.

This setup provides clear visibility into cluster health, resource usage, and application performance, and allows alerting to be easily introduced in the future using Prometheus Alertmanager.


## Runbooks

Runbooks for diagnosing and resolving common Kubernetes incidents/issues in this project:
- Pod CrashLoopBackOff
- Pod Pending / Scheduling failures
- ImagePullBackOff
- Service unavailable
- High CPU or memory usage
- ArgoCD sync failures

See '/runbooks' directory.
## Cost Estimate

This project was designed as a learning-focused DevOps platform, so costs were kept in mind during deployment and testing.

When the full environment is running, the main cost drivers are:

- Amazon EKS control plane: ~ $0.10 per hour
- EC2 worker nodes: depends on instance type (e.g., ~$0.01–$0.05 per hour for small instances)
- NAT Gateway: ~ $0.045 per hour
- Load balancer and networking resources: varies based on usage
- EBS volumes and data transfer: ~ $0.08–$0.10 per GB per month

Costs depend on runtime, traffic and node sizing, so the total spend will vary. 

**To minimize unnecessary charges, the infrastructure can be destroyed when not in use by running `terraform destroy`. After destruction, any leftover resources such as ECR images, state storage, or orphaned AWS networking dependencies should also be reviewed and cleaned up if no longer needed.**

## Future Improvements

- Add Prometheus Alertmanager for automated alerting and incident notifications.
- Implement Horizontal Pod Autoscaling (HPA) based on CPU and memory metrics.
- Introduce ingress with TLS for secure external access to services.
- Add log aggregation using a centralized logging stack (e.g., Loki or ELK).
- Implement cost monitoring and optimization for AWS resources.

