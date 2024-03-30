# module "vpc" {
#   source = "github.com/JeremyW1990/acme-module-vpc.git?ref=v1.0.0"

#   environment       = var.environment
#   cidr_block        = "10.0.0.0/16"
#   public_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
#   availability_zones = ["us-east-1a", "us-east-1b"]
#   vpc_name          = "acme-vpc"
# }

module "vpc" {
  source  = "app.terraform.io/ACME-TE/vpc/acme"
  version = "1.0.0"
  environment       = var.environment
  cidr_block        = "10.0.0.0/16"
  public_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  vpc_name          = "acme-vpc"
}

# module "acme_web_ec2_asg_alb" {
#   source = "github.com/JeremyW1990/acme-module-ec2_asg_alb?ref=v1.0.0"

#   environment       = var.environment
#   image_id          = "ami-0bd01824d64912730" # Example AMI ID; replace with a valid one
#   instance_type     = "t2.micro"
#   security_group_id = module.vpc.security_group_id
#   subnet_ids        = module.vpc.public_subnet_ids
#   vpc_id            = module.vpc.vpc_id
#   user_data = templatefile("./user_data.tpl", { environment = var.environment })

  
#   asg_min_size         = 1
#   asg_max_size         = 3
#   asg_desired_capacity = 2
# }

module "ec2_asg_alb" {
  source  = "app.terraform.io/ACME-TE/ec2_asg_alb/acme"
  version = "1.0.0"

  environment       = var.environment
  image_id          = "ami-0bd01824d64912730" # Example AMI ID; replace with a valid one
  instance_type     = "t2.micro"
  security_group_id = module.vpc.security_group_id
  subnet_ids        = module.vpc.public_subnet_ids
  vpc_id            = module.vpc.vpc_id
  user_data = templatefile("./user_data.tpl", { environment = var.environment })

  
  asg_min_size         = 1
  asg_max_size         = 3
  asg_desired_capacity = 2
}