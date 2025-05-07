# athena-3tier-infra
This project is a resilient, highly available, and secure 3-tier AWS architecture deployed manually and with Terraform. 

# Overview 
This project demonstrates the deployment of a modern 3-tier architecture using both manual steps and Infrastructure as Code (IaC). It incorporates core AWS services to ensure scalability, availability, and security. 

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
- This project was used using A Cloud Guru AWS (playground) for cost-effective environment and hands on testing. 
- The manual build was first documented in Notion with the ease of documentation for efficiency.