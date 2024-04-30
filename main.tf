module "vpc" {
  source            = "./modules/vpc"
  vpc_cidr          = "10.0.0.0/16"
  public_subnets_cidr = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones  = ["us-east-1a", "us-east-1b"]
}

module "ec2" {
  source            = "./modules/ec2"
  vpc_id            = module.vpc.vpc_id
  subnet_ids        = module.vpc.public_subnet_ids
  ami_id            = "ami-0b0ea68c435eb488d"
  instance_type     = "t2.micro"
  user_data         = file("${path.module}/user_data.sh")
  asg_min_size      = 2
  asg_max_size      = 5
  asg_desired_capacity = 3
}

output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "alb_dns_name" {
  value = module.ec2.alb_dns_name
}