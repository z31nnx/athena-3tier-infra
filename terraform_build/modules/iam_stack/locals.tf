locals {
  default_tags = {
    Name        = "${var.iam_role_name}"
    Environment = "${var.environment}"
    Project     = "${var.project}"
    Owner       = "${var.owner}"
    ManagedBy   = "${var.managedby}"
  }
}