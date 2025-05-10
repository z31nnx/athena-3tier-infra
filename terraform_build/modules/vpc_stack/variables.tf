/*This section allows us to define parameters for our infrastructure without hardcoding 
them in our main.tf which allows us to have flexible and reusable configurations*/

# For tags 
variable "environment" {}
variable "project" {}
variable "owner" {}
variable "managedby" {}

variable "vpc_name" {
  description = "The name of the VPC"
}
variable "cidr_block" {
  description = "CIDR block for the VPC"
}


