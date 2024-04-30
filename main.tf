module "my_vpc" {
  source = "./module/vpc"

  vpc_name        = "my-app-vpc"
  vpc_cidr        = "10.0.0.0/16"
  azs             = ["us-east-1a", "us-east-1b", "us-east-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]
  tags            = {
    "Environment" = "development"
    "Project"     = "MyApplication"
  }
}

module "my_ec2" {
  source          = "./module/ec2"
  application_name = "my-app"
  vpc_id           = module.my_vpc.vpc_id
  ami_id           = "ami-0b0ea68c435eb488d"
  instance_type    = "t3.micro"
  subnets          = module.my_vpc.public_subnets_ids
  min_size         = 1
  max_size         = 3
  desired_capacity = 1
  user_data        = file("userdata.sh")
}