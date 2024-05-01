module "vpc" {
  source           = "./modules/vpc"
  vpc_cidr         = var.vpc_cidr
  public_subnets   = var.public_subnets
  azs              = var.azs
}

module "ec2" {
  source           = "./modules/ec2"
  application_name = var.application_name
  ami_id           = var.ami_id
  instance_type    = var.instance_type
  asg_min_size     = var.asg_min_size
  asg_max_size     = var.asg_max_size
  asg_desired_capacity = var.asg_desired_capacity
  subnet_ids       = module.vpc.public_subnet_ids
  vpc_id           = module.vpc.vpc_id
}