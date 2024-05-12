provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source             = "./modules/vpc"
  cidr_block         = var.vpc_cidr_block
  subnet_cidr_blocks = var.vpc_subnet_cidr_blocks
  availability_zones = var.vpc_availability_zones
}

module "ec2" {
  source             = "./modules/ec2"
  vpc_id             = module.vpc.vpc_id
  subnet_ids         = module.vpc.subnet_ids
  ami_id             = var.ec2_ami_id
  instance_type      = var.ec2_instance_type
  asg_min_size       = var.ec2_asg_min_size
  asg_max_size       = var.ec2_asg_max_size
  asg_desired_capacity = var.ec2_asg_desired_capacity
  alb_access_cidr    = var.ec2_alb_access_cidr
}