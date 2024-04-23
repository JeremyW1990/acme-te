module "vpc" {
  source = "./modules/vpc"

  vpc_cidr          = "10.0.0.0/16"
  vpc_name          = "myapplication-vpc"
  subnets_cidr      = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones= ["us-east-1a", "us-east-1b"]
  map_public_ip_on_launch = true          
  public_subnets_cidr     = ["10.0.1.0/24", "10.0.2.0/24"]
  # additional parameters can be added here
}

module "ec2" {
  source = "./modules/ec2"

  vpc_id              = module.vpc.vpc_id
  subnet_ids          = module.vpc.subnet_ids
  application_name    = "myapplication"
  asg_desired_capacity= 2
  asg_max_size        = 5
  asg_min_size        = 2
  ami_id              = "ami-0c55b159cbfafe1f0" # Example, change it to the actual AMI ID.
  instance_type       = "t2.micro" # or the actual desired instance type
  # additional parameters can be added here
}