module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnets_cidrs = ["10.0.1.0/24", "10.0.2.0/24"]
}

module "ec2" {
  source              = "./modules/ec2"
  ami_id              = "ami-0b0ea68c435eb488d"
  instance_type       = "t2.micro"
  subnets             = module.vpc.public_subnets_ids
  vpc_id              = module.vpc.vpc_id
  asg_max_size        = 3
  asg_min_size        = 1
  asg_desired_capacity = 2
}

output "application_url" {
  value       = "http://${module.ec2.app_load_balancer_dns_name}"
  description = "URL to access the application"
}