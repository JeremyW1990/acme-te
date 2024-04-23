module "vpc" {
  source             = "./modules/vpc"
  vpc_cidr           = "10.0.0.0/16"
  public_subnets     = ["10.0.1.0/24", "10.0.2.0/24"]
  private_subnets    = ["10.0.3.0/24", "10.0.4.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
}

module "ec2" {
  source         = "./modules/ec2"
  ami_id         = "ami-0c55b159cbfafe1f0" # example AMI ID, replace with your actual AMI ID
  instance_type  = "t2.micro"
  key_name       = "your-key-name" # replace with your actual key name
  vpc_id         = module.vpc.vpc_id
  subnet_ids     = module.vpc.public_subnet_ids
  security_groups= [module.vpc.vpc_id] # this may need to be replaced with actual security group IDs
  user_data      = file("${path.module}/modules/ec2/user_data.sh")
  desired_capacity = 2
  min_size       = 1
  max_size       = 3
  tags = {
    Project = "My Application"
  }
}