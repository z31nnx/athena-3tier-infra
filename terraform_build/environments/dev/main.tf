# Root 
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = ">= 5.0"
    }
  }
}

locals {
  global_tags = {
    Environment = var.environment
    Owner       = var.owner
    Project     = var.project
    ManagedBy   = var.managedby
  }
}


provider "aws" {
  region = "us-east-1"
}

module "vpc_stack" {
  source     = "../../modules/vpc_stack"
  vpc_name   = var.vpc_name
  cidr_block = var.cidr_block
  tags       = local.global_tags
}

module "security_groups" {
  source = "../../modules/security_groups"
  vpc_id = module.vpc_stack.vpc_id
  tags   = local.global_tags
}

module "iam_stack" {
  source                    = "../../modules/iam_stack"
  iam_instance_profile_name = var.iam_instance_profile_name
  iam_role_name             = var.iam_role_name
  tags                      = local.global_tags
}

module "launch_template" {
  source                    = "../../modules/launch_template"
  athena_web_sg_id          = module.security_groups.athena_web_sg_id
  athena_app_sg_id          = module.security_groups.athena_app_sg_id
  ec2_instance_profile_name = module.iam_stack.ec2_instance_profile_name
  ec2_name                  = var.ec2_name
  instance_types            = var.instance_types
  tags                      = local.global_tags
}

module "alb_stack" {
  source               = "../../modules/alb_stack"
  vpc_id               = module.vpc_stack.vpc_id
  alb_public_subnets   = module.vpc_stack.public_subnets_id
  alb_private_subnets  = module.vpc_stack.private_subnets_id_per_az
  athena_web_alb_sg_id = module.security_groups.athena_web_alb_sg_id
  athena_app_alb_sg_id = module.security_groups.athena_app_alb_sg_id
  tags                 = local.global_tags
}

module "asg_stack" {
  source              = "../../modules/asg_stack"
  web_launch_template = module.launch_template.launch_template_names["web"]
  app_launch_template = module.launch_template.launch_template_names["app"]
  asg_public_subnets  = module.vpc_stack.public_subnets_id
  asg_private_subnets = module.vpc_stack.private_subnets_id_per_az
  web_alb_tg_arn      = module.alb_stack.alb_target_group_arns["web"]
  app_alb_tg_arn      = module.alb_stack.alb_target_group_arns["app"]
  environment         = local.global_tags.Environment
  owner               = local.global_tags.Owner
  project             = local.global_tags.Project
  managedby           = local.global_tags.ManagedBy
}

module "rds_stack" {
  source               = "../../modules/rds_stack"
  db_private_subnets   = module.vpc_stack.private_subnets_id_per_az
  athena_db_sg_id      = module.security_groups.athena_data_sg_id
  db_subnet_group_name = var.db_subnet_group_name
  db_name              = var.db_name
  db_username          = var.db_username
  db_password          = var.db_password
  tags                 = local.global_tags

}