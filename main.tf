provider "aws" {
  region = "us-east-1"
}

module "vpc" {
  source = "./module/vpc"

  vpc_cidr       = "10.0.0.0/16"
  public_subnets  = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets = ["10.0.3.0/24", "10.0.4.0/24"]
}

module "ec2" {
  source              = "./module/ec2"
  ami_id              = "ami-0b0ea68c435eb488d"
  instance_type       = "t2.micro"
  vpc_id              = module.vpc.vpc_id
  vpc_zone_identifier = module.vpc.public_subnets
  alb_subnets         = module.vpc.public_subnets

  # Userdata for setting up a simple homepage
  user_data = <<-EOF
              #!/bin/bash
              echo "Auto Deployment from Cloud-AI" > /var/www/html/index.html
              EOF
}
