
# Tags 
variable "environment" {}
variable "project" {}
variable "owner" {}
variable "managedby" {}

variable "asg_names" {
  type = map(string)
  default = {
    web = "athena_web_asg"
    app = "athena_app_asg"
  }
}

variable "web_launch_template" {}
variable "app_launch_template" {}
variable "asg_public_subnets" {}
variable "asg_private_subnets" {}
variable "web_alb_tg_arn" {}
variable "app_alb_tg_arn" {}
