provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source                  = "./module/vpc"
  cidr_block              = var.vpc_cidr_block
  instance_tenancy        = var.vpc_instance_tenancy
  enable_dns_hostnames    = var.vpc_enable_dns_hostnames
  enable_dns_support      = var.vpc_enable_dns_support
  name                    = var.vpc_name
  public_subnets          = var.vpc_public_subnets
  private_subnets         = var.vpc_private_subnets
  availability_zones      = var.vpc_availability_zones
  map_public_ip_on_launch = var.vpc_map_public_ip_on_launch
}

module "ec2" {
  source                = "./module/ec2"
  ami_id                = var.ec2_ami_id
  instance_type         = var.ec2_instance_type
  enable_monitoring     = var.ec2_enable_monitoring
  vpc_id                = module.vpc.vpc_id
  subnets               = module.vpc.public_subnets
  asg_min_size          = var.ec2_asg_min_size
  asg_max_size          = var.ec2_asg_max_size
  asg_desired_capacity  = var.ec2_asg_desired_capacity
  name                  = var.ec2_name
  public_subnets        = module.vpc.public_subnets
}