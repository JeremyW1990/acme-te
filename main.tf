provider "aws" {
  region = var.aws_region
}

module "vpc_module" {
  source              = "./terraform-modules/vpc"
  vpc_name            = "main-vpc"
  vpc_cidr            = "10.0.0.0/16"
  azs                 = var.availability_zones
  private_subnets     = var.private_subnets_cidr
  public_subnets      = var.public_subnets_cidr
  project_name        = var.project_name
}

module "ec2_module" {
  source              = "./terraform-modules/ec2"
  vpc_id              = module.vpc_module.vpc_id
  subnets             = module.vpc_module.private_subnets
  public_subnets      = module.vpc_module.public_subnets
  ami_id              = var.ami_id
  instance_type       = var.instance_type
  max_size            = var.asg_max_size
  min_size            = var.asg_min_size
  desired_capacity    = var.asg_desired_capacity
}