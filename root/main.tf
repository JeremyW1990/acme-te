module "vpc" {
  source = "../modules/vpc"

  vpc_cidr              = "10.0.0.0/16"
  public_subnets_cidr   = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones    = ["us-east-1a", "us-east-1b"]
}

module "ec2" {
  source = "../modules/ec2"

  vpc_id           = module.vpc.vpc_id
  subnet_ids       = module.vpc.public_subnets
  ami_id           = "ami-0b0ea68c435eb488d"
  instance_type    = "t2.micro"
  min_size         = 1
  max_size         = 2
  desired_capacity = 1
}

output "application_url" {
  value = "http://${module.ec2.alb_dns_name}"
  description = "URL to access the deployed application"
}