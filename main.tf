module "vpc" {
  source             = "./module/vpc"
  cidr_block         = "10.0.0.0/16"
  public_subnets_cidr = [
    "10.0.1.0/24",
    "10.0.2.0/24",
    "10.0.3.0/24"
  ]
  availability_zones = [
    "us-east-1a",
    "us-east-1b",
    "us-east-1c"
  ]
}

module "ec2" {
  source            = "./module/ec2"
  ami_id            = "ami-0b0ea68c435eb488d"
  instance_type     = "t2.micro"
  vpc_id            = module.vpc.vpc_id
  public_subnets    = module.vpc.public_subnets
  asg_min_size      = 1
  asg_max_size      = 3
  asg_desired_capacity = 2
}