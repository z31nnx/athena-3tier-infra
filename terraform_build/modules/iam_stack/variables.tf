variable "tags" {
  type = map(string)
}
variable "iam_role_name" {}
variable "iam_instance_profile_name" {}
variable "iam_managed_policies" {
  type = map(string)
  default = {
    AmazonSSMManagedInstanceCore = "arn:aws:iam::aws:policy/AmazonSSMManagedInstanceCore"
    CloudWatchAgentServerPolicy  = "arn:aws:iam::aws:policy/CloudWatchAgentServerPolicy"
  }
}
