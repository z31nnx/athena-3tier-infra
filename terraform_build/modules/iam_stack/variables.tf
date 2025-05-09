/*This section allows us to define parameters for our infrastructure without hardcoding 
them in our main.tf which allows us to have flexible and reusable configurations*/


variable "iam_role_name" {}
variable "iam_instance_profile_name" {}
variable "iam_managed_policies" {
  type = map(string)
  default = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    CloudWatchAgentServerPolicy  = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  }
}

# For tags 
variable "environment" {}
variable "project" {}
variable "owner" {}
variable "managedby" {}
