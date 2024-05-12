provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source             = "./module/vpc"
  vpc_cidr           = var.vpc_cidr
  availability_zones = var.availability_zones
}

module "ec2" {
  source          = "./module/ec2"
  vpc_id          = module.vpc.vpc_id
  subnets         = module.vpc.public_subnets
  ami_id          = var.ami_id
  instance_type   = var.instance_type
  min_size        = var.asg_min_size
  max_size        = var.asg_max_size
  desired_capacity = var.asg_desired_capacity
  server_port     = var.server_port
}