locals {
  default_tags = {
    Name        = "${var.sg_names}"
    Environment = "${var.environment}"
    Project     = "${var.project}"
    Owner       = "${var.owner}"
    ManagedBy   = "${var.managedby}"
  }
}