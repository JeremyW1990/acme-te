module "vpc" {
  source             = "./modules/vpc"
  name_suffix        = "app"
  vpc_cidr           = "10.0.0.0/16"
  public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

module "ec2" {
  source      = "./modules/ec2"
  name_suffix = "app"
  vpc_id      = module.vpc.vpc_id
  subnet_ids  = module.vpc.public_subnet_ids
  ami_id      = "ami-12345678" # Replace with the actual AMI ID
  instance_type = "t2.micro"
  asg_min_size  = 1
  asg_max_size  = 3
  asg_desired_capacity = 2
}