module "vpc" {
  source = "https://github.com/JeremyW1990/acme-module-vpc.git?ref=v1.0.0"

  cidr_block        = "10.0.0.0/16"
  public_subnets    = ["10.0.1.0/24", "10.0.2.0/24"]
  availability_zones = ["us-east-1a", "us-east-1b"]
  vpc_name          = "acme-vpc"
}
