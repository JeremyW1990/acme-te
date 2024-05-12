provider "aws" {
  region = var.aws_region
}

module "vpc" {
  source      = "./module/vpc"
  vpc_cidr    = var.vpc_cidr
  public_subnets_cidr = var.public_subnets_cidr
  azs         = var.azs
}

module "ec2" {
  source      = "./module/ec2"
  vpc_id      = module.vpc.vpc_id
  subnets     = module.vpc.public_subnets
  ami_id      = var.ami_id
  instance_type = var.instance_type
  userdata_script = var.userdata_script
  autoscaling_min_size = var.autoscaling_min_size
  autoscaling_max_size = var.autoscaling_max_size
  autoscaling_desired_capacity = var.autoscaling_desired_capacity
}

output "application_load_balancer_dns" {
  value = module.ec2.lb_dns_name
}