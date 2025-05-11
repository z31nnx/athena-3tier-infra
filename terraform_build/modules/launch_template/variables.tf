variable "tags" {
  type = map(string)
}

variable "launch_template_names" {
  type = map(string)
  default = {
    web = "athena_web_lt"
    app = "athena_app_lt"
  }
}

# EC2 aunch template variables 
variable "ec2_name" {}
variable "instance_types" {}
variable "ec2_instance_profile_name" {}
variable "athena_web_sg_id" {}
variable "athena_app_sg_id" {}
