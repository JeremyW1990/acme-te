provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source              = "./modules/vpc"
  cidr_block          = "10.0.0.0/16"
  subnet_cidr_blocks  = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}

module "ec2" {
  source              = "./modules/ec2"
  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.subnet_ids
}