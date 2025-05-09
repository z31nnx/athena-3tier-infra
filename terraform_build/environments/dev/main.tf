terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

provider "aws" {
  region = "us-east-1"
}

module "vpc_stack" {
  source      = "../../modules/vpc_stack"
  vpc_name    = var.vpc_name
  cidr_block  = var.cidr_block
  environment = var.environment
  owner       = var.owner
  project     = var.project
  managedby   = var.managedby
}

module "security_groups" {
  source      = "../../modules/security_groups"
  vpc_id      = module.vpc_stack.vpc_id
  environment = var.environment
  owner       = var.owner
  project     = var.project
  managedby   = var.managedby
}

module "iam_stack" {
  source                    = "../../modules/iam_stack"
  iam_instance_profile_name = var.iam_instance_profile_name
  iam_role_name             = var.iam_role_name
  environment               = var.environment
  owner                     = var.owner
  project                   = var.project
  managedby                 = var.managedby
}

