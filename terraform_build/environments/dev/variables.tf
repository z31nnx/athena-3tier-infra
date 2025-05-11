/*This section allows us to define parameters for our infrastructure without hardcoding 
them in our main.tf which allows us to have flexible and reusable configurations*/

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

# RDS 
variable "db_subnet_group_name" {}
variable "db_name" {}
variable "db_username" {
  sensitive = true
  type      = string
}
variable "db_password" {
  type      = string
  sensitive = true
}