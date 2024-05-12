provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source        = "./module/vpc"
  cidr_block    = var.vpc_cidr_block
  public_subnets = var.public_subnets
}

module "ec2" {
  source          = "./module/ec2"
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  vpc_id          = module.vpc.vpc_id
  subnet_ids      = module.vpc.public_subnet_ids
  asg_min_size    = var.asg_min_size
  asg_max_size    = var.asg_max_size
  asg_desired_capacity = var.asg_desired_capacity
}