provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source              = "./module/vpc"
  aws_region          = var.aws_region
  application_name    = var.application_name
  vpc_cidr            = var.vpc_cidr
  public_subnet_cidrs = var.public_subnet_cidrs
  availability_zones  = var.availability_zones
}

module "ec2" {
  source          = "./module/ec2"
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  asg_min_size    = var.asg_min_size
  asg_max_size    = var.asg_max_size
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnet_ids
  application_name = var.application_name
}