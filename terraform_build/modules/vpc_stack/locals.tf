# Locals allows us to reuse code that wemight code often, also can integrate with variables together 
locals {
  public_subnets = {
    public_subnet_1 = { cidr_block = "10.0.1.0/24", az = "us-east-1a" }
    public_subnet_2 = { cidr_block = "10.0.2.0/24", az = "us-east-1b" }
  }
  private_subnets = {
    private_subnet_1 = { cidr_block = "10.0.3.0/24", az = "us-east-1a" }
    private_subnet_2 = { cidr_block = "10.0.4.0/24", az = "us-east-1b" }
    private_subnet_3 = { cidr_block = "10.0.5.0/24", az = "us-east-1a" }
    private_subnet_4 = { cidr_block = "10.0.6.0/24", az = "us-east-1b" }
  }
  default_tags = {
    Name        = "${var.vpc_name}"
    Environment = "${var.environment}"
    Project     = "${var.project}"
    Owner       = "${var.owner}"
    ManagedBy   = "${var.managedby}"
  }
}