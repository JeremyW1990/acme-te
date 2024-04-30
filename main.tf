module "vpc" {
  source = "./module/vpc"

  vpc_cidr           = "10.0.0.0/16"
  public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
  vpc_name           = "cloud-ai-vpc"
}

module "ec2" {
  source = "./module/ec2"

  vpc_id                = module.vpc.vpc_id
  subnets               = module.vpc.public_subnets_ids
  ami_id                = "ami-0b0ea68c435eb488d"
  instance_type         = "t2.micro"
  app_name              = "cloud-ai-app"
  alb_security_group_name = "cloud-ai-alb-sg"
  ec2_security_group_name = "cloud-ai-ec2-sg"
  asg_min_size          = 1
  asg_max_size          = 2
  asg_desired_capacity  = 1
  server_port           = 80
}