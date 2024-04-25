module "vpc" {
  source = "./modules/vpc"

  cidr_block           = var.vpc_cidr_block
  public_subnets_cidr  = var.public_subnets_cidr
  availability_zones   = var.availability_zones
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.public_subnets
  image_id            = var.image_id
  instance_type       = var.instance_type
  asg_min_size        = var.asg_min_size
  asg_max_size        = var.asg_max_size
  asg_desired_capacity = var.asg_desired_capacity
  environment         = var.environment
}