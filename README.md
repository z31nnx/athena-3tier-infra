# Trident AWS 3-Tier Infra
This project is a resilient, highly available, and secure 3-tier AWS architecture deployed manually and with **Terraform** (IaC). 

> **Renaming Notice — Sep 2025**
>
> This project was previously named **Athena**. It was renamed to **Trident** to avoid **service/resource naming collisions** (e.g., security groups, ALBs, ASGs, RDS identifiers).  
> Any screenshots or tags that still show `athena-*` refer to the same project prior to the rename.

# Overview 
This project demonstrates the deployment of a modern 3-tier architecture using both manual steps and Infrastructure as Code (IaC). It incorporates core AWS services to ensure scalability, availability, and security. 

![Trident-3-Tier-Architecture-Diagram](/diagram/trident-3-Tier-Diagram.png) 

# Builds
- Manual build: **[Click Here](/manual_build/README.MD)**
- Terraform build: **[Click Here](/terraform/README.MD)**

# Key Features
- VPC with Public & Private Subnets 
- Security Groups for network segmentation 
- EC2 with SSM (session manager) for secure portless access 
- Autoscaling Group (ASG) for dynamic scalability 
- Application Load Balancer (ALB) for traffic distribution 
- NAT Gateway (NAT) and Internet Gateway (IGW) for Internet Access
- IAM Role for EC2 aligning with best practices 
- RDS database for data storage 

# Tools 
- This project was done using A Cloud Guru AWS (playground) for cost-effective environment and hands on testing. 
- The manual build was first documented in Notion with the ease of documentation for efficiency.
