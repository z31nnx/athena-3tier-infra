variable "tags" {
  type = map(string)
}

variable "db_subnet_group_name" {}
variable "athena_db_sg_id" {}
variable "db_name" {}
variable "db_private_subnets" {}
variable "db_username" {
  sensitive = true
  type      = string
}
variable "db_password" {
  type      = string
  sensitive = true
}