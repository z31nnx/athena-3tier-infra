/*This section allows us to define parameters for our infrastructure without hardcoding 
them in our main.tf which allows us to have flexible and reusable configurations*/

variable "sg_names" { # A map of security group names, allows choosing names for the code 
  type = map(string)
  default = {
    "web_alb" = "athena-web-alb-sg"
    "web"     = "athena-web-sg"
    "app_alb" = "athena-app-alb-sg"
    "app"     = "athena-app-sg"
    "data"    = "athena-data-sg"
  }
}

variable "sg_ports" {      # Port numbers, used in dynamic blocks 
  type = map(list(number)) # A map, a list, and numbers 
  default = {
    http     = [80]
    web_alb  = [80, 443]
    database = [3306]
  }
}

variable "vpc_id" {} # The VPC from the VPC module, it will be used in security groups resources 

# For tags 
variable "environment" {}
variable "project" {}
variable "owner" {}
variable "managedby" {}
