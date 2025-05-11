variable "tags" {
  type = map(string)
}
variable "vpc_name" {
  description = "The name of the VPC"
}
variable "cidr_block" {
  description = "CIDR block for the VPC"
}


