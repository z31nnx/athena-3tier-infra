# Trident 3-Tier Terraform Architecture

This section contains the Terraform configuration used to **automate the 3-tier infrastructure**.

## Overview

Trident is a **modular 3-tier AWS architecture** built with Terraform.  
It mirrors a production-ready cloud environment with:

- **High Availability**: Multi-AZ design with resilient services  
- **Auto Scaling**: Dynamic scaling policies based on CloudWatch metrics  
- **Least Privilege**: IAM roles and scoped security groups  
- **Infrastructure as Code**: Modular, reusable, and version-controlled  

## Architecture Overview & Diagram
![Trident-3-Tier-Architecture-Diagram](/diagram/trident-3-Tier-Diagram.png)

## Modules

| Module             | Purpose                                    | Key Features                                                                 |
|--------------------|--------------------------------------------|------------------------------------------------------------------------------|
| **vpc_stack**      | Networking foundation                      | VPC, IGW, NAT, 6 subnets (2 public, 4 private), routing, outputs             |
| **security_groups**| Network segmentation                       | 5 SGs (Web ALB, Web EC2, App ALB, App EC2, RDS/Data); dynamic ingress rules  |
| **iam_stack**      | IAM role + instance profile                | SSM Session Manager, CloudWatch policies; attached via launch templates      |
| **launch_template**| Compute templates                          | Web + App templates, Amazon Linux 2, encrypted gp3 EBS, user_data, monitoring|
| **alb_stack**      | Load balancing                             | Web ALB (public) + App ALB (internal), target groups, listeners, health checks|
| **asg_stack**      | Elastic scaling                            | 2 ASGs with CPU target tracking (70%), lifecycle aware, tagged for traceability|
| **rds_stack**      | Database layer                             | Multi-AZ MySQL 8.0, subnet group, SG, encryption, backups enabled            |

## Requirements
- **Terraform**: [Install Guide](https://developer.hashicorp.com/terraform/install)  
- **AWS CLI v2**: [Setup Guide](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-install.html)  
- **Quick Setup (`aws configure`)**: [Tutorial](https://docs.aws.amazon.com/cli/latest/userguide/getting-started-quickstart.html)  
- Provide your own `.tfvars` with variable inputs (excluded from repo for security).  
- A sample file is included: [terraform.tfvars.example](/terraform/terraform.tfvars.example)  

⚠️ **Never commit tfvars with secrets to version control.**

## How to Deploy
```bash
# Navigate into dev environment
cd terraform/envs/dev

# Initialize modules & backend
terraform init

# Preview infrastructure changes
terraform plan -var-file="terraform.tfvars"

# Deploy
terraform apply -var-file="terraform.tfvars"

```
## How to destroy  
```bash
cd terraform/envs/dev
terraform destroy -var-file="terraform.tfvars"
```

## Manual Documentation
- For detailed implementation notes, see: **[here](/manual_build/README.MD)**

