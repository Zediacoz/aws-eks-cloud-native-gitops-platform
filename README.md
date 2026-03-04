# Production-Style Kubernetes Platform on AWS (Terraform + GitOps + Observability)


This project demonstrates the design and operation of a production-style Kubernetes platform on AWS using Infrastructure as Code, GitOps, and full observability.

The platform provisions AWS infrastructure with Terraform, deploys applications through ArgoCD GitOps workflows, and provides cluster observability using Prometheus and Grafana. 

The platform is built using Terraform to provision cloud infrastructure, Kubernetes for workload orchestration, and CI/CD pipelines to enable repeatable, low-risk deployments. 
Prometheus and Grafana provide monitoring and alerting, supported by runbooks and incident documentation that reflect real on-call operations. Cost efficiency is treated as a first-class concern, with autoscaling, right-sized resource requests, and documented cost guardrails designed to reduce waste while maintaining reliability. 

The goal of this project is to demonstrate hands-on DevOps engineering skills across the full lifecycle: designing infrastructure, 
deploying and operating services in production-like environments, responding to incidents, and continuously improving reliability and cost efficiency.
