locals {
  default_tags = {
    Environment = var.environment
    Owner       = var.owner
    Project     = var.project
    ManagedBy   = var.managedby
  }
}
