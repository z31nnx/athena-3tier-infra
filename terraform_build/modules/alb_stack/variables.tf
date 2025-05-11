/*This section allows us to define parameters for our infrastructure without hardcoding 
them in our main.tf which allows us to have flexible and reusable configurations*/

variable "tags" {
  type = map(string)
}
# Application load balancer 
variable "alb_names" {
  type = map(string)
  default = {
    web = "athena-web-alb"
    app = "athena-app-alb"
  }
}

variable "vpc_id" {}              # Athena VPC id 
variable "alb_public_subnets" {}  # Subnets from Athena VPC 
variable "alb_private_subnets" {} # Subnets from Athena VPC
variable "athena_web_alb_sg_id" {}
variable "athena_app_alb_sg_id" {}