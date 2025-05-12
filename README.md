# athena-3tier-infra
This project is a resilient, highly available, and secure 3-tier AWS architecture deployed manually and with Terraform. 

# Overview 
This project demonstrates the deployment of a modern 3-tier architecture using both manual steps and Infrastructure as Code (IaC). It incorporates core AWS services to ensure scalability, availability, and security. 

## Builds
- Manual build: **[manual_build](/manual_build/README.MD)**
- Terraform build: **[terraform_build](/terraform_build/README.MD)**

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

--- 
> This project demonstrates both practical infrastructure understanding and the ability to deploy it using code.  