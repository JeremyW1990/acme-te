module "vpc" {
  source = "./modules/vpc"

  cidr_block        = "10.0.0.0/16"
  public_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  vpc_name          = "acme-vpc"
}
