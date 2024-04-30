module "vpc" {
  source = "./module/vpc"

  vpc_cidr          = var.vpc_cidr
  public_subnets    = var.public_subnets
  availability_zones = var.availability_zones
}

module "ec2" {
  source = "./module/ec2"

  ami_id           = var.ami_id
  instance_type    = var.instance_type
  subnet_ids       = module.vpc.public_subnets
  vpc_id           = module.vpc.vpc_id
  security_group_id = module.vpc.security_group_id
  asg_min_size     = var.asg_min_size
  asg_max_size     = var.asg_max_size
}