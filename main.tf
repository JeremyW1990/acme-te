module "vpc" {
  source      = "./modules/vpc"
  cidr_block  = "10.0.0.0/16"
}

module "ec2" {
  source       = "./modules/ec2"
  ami_id       = "ami-0b0ea68c435eb488d"
  instance_type = "t2.micro"
  min_size     = 1
  max_size     = 2
  vpc_id       = module.vpc.vpc_id
  subnet_ids   = [module.vpc.public_subnet_id]
}

output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = module.vpc.public_subnet_id
}

output "autoscaling_group_id" {
  description = "The ID of the autoscaling group."
  value       = module.ec2.autoscaling_group_id
}

output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer, used to access the application."
  value       = module.ec2.load_balancer_dns_name
}