terraform {
  required_providers {
    aws = {
        source = "hashicorp/aws"
        version = ">= 5.0"
    }
  }
}

provider "aws" {
    region = "us-east-1"
}

module "vpc_stack" {
    source = "../../modules/vpc_stack"
    vpc_name = var.vpc_name
    cidr_block = var.cidr_block
    environment = var.environment
    owner = var.owner
    team = var.team

}