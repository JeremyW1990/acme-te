module "vpc" {
  source        = "../../modules/vpc"
  vpc_cidr      = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
}

module "ec2" {
  source        = "../../modules/ec2"
  vpc_id        = module.vpc.vpc_id
  subnets       = [module.vpc.public_subnet_id] # Assuming we want the autoscaling group in the public subnet
  image_id      = "ami-1234567890abcdef0" # Replace with your desired AMI ID
  instance_type = "t2.micro"
  app_port      = 80
  asg_min_size  = 1
  asg_max_size  = 3
  asg_desired_capacity = 2
  health_check_path = "/health"
}

provider "aws" {
  region = "us-east-1"
}