module "vpc" {
  source = "./module/vpc"

  # Optionally, override the defaults from the VPC module
  vpc_cidr           = "10.0.0.0/16"
  public_subnet_cidr = "10.0.1.0/24"
}

module "ec2" {
  source  = "./module/ec2"

  vpc_id     = module.vpc.vpc_id
  subnet_ids = [module.vpc.public_subnet_id]
  
  ami_id         = "ami-0b0ea68c435eb488d"
  instance_type  = "t2.micro"
  asg_min_size   = 1
  asg_max_size   = 3
  server_port    = 80
}

output "application_url" {
  description = "URL of the application load balancer"
  value       = module.ec2.alb_dns_name
}