# Tags 
variable "environment" {}
variable "project" {}
variable "owner" {}
variable "managedby" {}

# VPC
variable "vpc_name" {}
variable "cidr_block" {}

# IAM variables
variable "iam_role_name" {}
variable "iam_instance_profile_name" {}

# Launch templates 
variable "ec2_name" {}
variable "instance_types" {}
