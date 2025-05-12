# Athena 3-Tier Terraform Architecture

This section contains the Terraform configuration used to automate the infrastructure.

## Overview

Athena is a **modular 3-tier infrastructure** built using Terraform.  
It simulates a realistic cloud architecture with **high availability**, **auto scaling**, and **least privilege**, all managed as code.

## Architecture Overview & Diagram 
![Athena-3-Tier-Architecture-Diagram](/diagram/Athena-3-Tier-Diagram.png)

- **6 Subnets** across 2 Availability Zones
  - 2 Public Subnets
  - 4 Private Subnets
- **2 Application Load Balancers** (Web + App tiers)
- **2 Launch Templates** with user data (App + Web)
- **2 Auto Scaling Groups** with CPU target tracking
- **1 MySQL RDS (multi-AZ standby)** with subnet group + security
- **5 Security Groups** for network segmentation
- **SSM Access (No SSH)** for portless, best practice remote connection
- **Remote state backend (S3 + Locking via S3 Lockfile)** 

# Remote backend (S3+ lockfile)
- S3 bucket with versioning & SSE-S3 (AES256)
- No DynamoDB (deprecated, use **use_lockfile = true** instead)
- Lifecycle rules (optional) for cleanup
- Backend config lives in /environments/dev/backend.tf 

## Requirements
- Terraform v5.0+
- AWS CLI authenticated with IAM permissions
- Remote state bucket created (or initialize backend first)
- You'll need your own tfvars with proper variable inputs. I have excluded mine for best practice. **Never commit tfvars to version control.** 
- A sample `terraform.tfvars.example` file is included to help you structure your variable inputs. See **[here](/terraform_build/terraform.tfvars.example)**

## How to Use
Follow these steps to deploy the full Athena 3-tier architecture from scratch.
Make sure you configure your aws credentials first using this command `aws configure`
and enter your access key, secret key, region, and output format.
Navigate to the `backend` folder and apply the remote state infrastructure. 

```bash
 cd terraform_build/backend
 terraform init
 terraform plan -var-file="terraform.tfvars"
 terraform apply -var-file="terraform.tfvars" 
```
Then, move into the `environments/dev` directory and deploy the infrastructure.
```bash
cd ../environments/dev
terraform init
terraform plan -var-file="terraform.tfvars"
terraform apply -var-file="terraform.tfvars"
```

## How to destroy 

**Destroy Infra**
  
  ```bash
  cd terraform_build/environments/dev
  terraform destroy -var-file="terraform.tfvars"
  ```

**Empty Bucket**
Empty the S3 bucket if needed

```bash
aws s3 rm s3://athena-tfstate-bucket --recursive
```

**Destroy Backend**
  ```bash
  cd terraform_build/backend
  terraform destroy -var-file="terraform.tfvars"
```
⚠️ **Always destroy in reverse order of creation.**

---

## Modules

**vpc_stack**
- Creates VPC, IGW, NAT, and routing
- Defines 6 subnets: 2 public, 4 private
- Subnets split across 2 AZs for HA
- Exposes outputs for subnet IDs and VPC ID

**security_groups**
- 5 total SGs:
- Web ALB (0.0.0.0/0 on 80/443)
- Web EC2 (from ALB SG)
- App ALB (from Web EC2 SG)
- App EC2 (from App ALB SG)
- RDS/Data (from App EC2 SG on 3306)
- Dynamic blocks for ingress rules

**iam_stack**
- IAM role + instance profile
- Policies for SSM Session Manager and CloudWatch
- Attached to EC2 via launch template

**launch_template**
- One for web, one for app
- Loads AMI (Amazon Linux 2)
- Encrypted gp3 EBS volumes
- Includes user_data, monitoring, and tags

**alb_stack**
- Two ALBs (web: public, app: internal)
- Target groups and listeners for each
- Health checks to /index.html and /app/index.html

**asg_stack**
- 2 ASGs, connected to launch templates
- ASG scaling policy via CPU target tracking (70%)
- Terraform should not control scaling here
- Note: Terraform defines ASG policies but does **not** handle real-time scaling adjustments—those are managed by AWS based on CloudWatch metrics.
- Lifecycle aware and tagged for traceability

**rds_stack**
- Multi-AZ MySQL 8.0 (RDS Standby)
- Subnet group and security group attached
- Public access disabled
- skip_final_snapshot = true (for sandbox) not recommended for prod, set to false for prod 
- Encrypted, with backup enabled

## Manual Documentation
- For detailed implementation notes, see: **[here](/manual_build/README.MD)**

