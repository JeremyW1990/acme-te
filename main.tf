provider "aws" {
  region = var.region
}

module "vpc" {
  source                = "./modules/vpc"
  vpc_cidr              = var.vpc_cidr
  vpc_name              = var.vpc_name
  public_subnets_cidrs  = var.public_subnets_cidrs
  availability_zones    = var.availability_zones
}

module "ec2" {
  source               = "./modules/ec2"
  vpc_id               = module.vpc.vpc_id
  subnets              = module.vpc.public_subnets
  ami_id               = var.ami_id
  instance_type        = var.instance_type
  asg_min_size         = var.asg_min_size
  asg_max_size         = var.asg_max_size
  asg_desired_capacity = var.asg_desired_capacity
}
