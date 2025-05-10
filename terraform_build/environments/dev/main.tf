# Root 
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

module "launch_template" {
  source                    = "../../modules/launch_template"
  athena_web_sg_id          = module.security_groups.athena_web_sg_id
  athena_app_sg_id          = module.security_groups.athena_app_sg_id
  ec2_instance_profile_name = module.iam_stack.ec2_instance_profile_name
  ec2_name                  = var.ec2_name
  instance_types            = var.instance_types
  environment               = var.environment
  owner                     = var.owner
  project                   = var.project
  managedby                 = var.managedby
}

module "alb_stack" {
  source                    = "../../modules/alb_stack"
  vpc_id                    = module.vpc_stack.vpc_id
  alb_public_subnets        = module.vpc_stack.public_subnets_id
  alb_private_subnets       = module.vpc_stack.private_subnets_id_for_alb
  athena_web_alb_sg_id      = module.security_groups.athena_web_alb_sg_id
  athena_app_alb_sg_id      = module.security_groups.athena_app_alb_sg_id
  environment               = var.environment
  owner                     = var.owner
  project                   = var.project
  managedby                 = var.managedby
}