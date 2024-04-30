module "vpc" {
  source = "./module/vpc"

  # VPC Configuration
  vpc_cidr          = var.vpc_cidr
  public_subnets    = var.public_subnets
  private_subnets   = var.private_subnets
  enable_nat_gateway = var.enable_nat_gateway
}

resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  tags = {
    Name = "Main VPC"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets)

  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnets[count.index]
  map_public_ip_on_launch = true

  tags = {
    Name = "Public Subnet ${count.index}"
  }
}

resource "aws_subnet" "private" {
  count = length(var.private_subnets)

  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnets[count.index]

  tags = {
    Name = "Private Subnet ${count.index}"
  }
}

resource "aws_internet_gateway" "gw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "Main Internet Gateway"
  }
}

resource "aws_nat_gateway" "nat" {
  count = var.enable_nat_gateway ? 1 : 0

  subnet_id     = aws_subnet.public[0].id
  allocation_id = aws_eip.nat.id
  tags = {
    Name = "Main NAT Gateway"
  }
}

resource "aws_eip" "nat" {
  count = var.enable_nat_gateway ? 1 : 0

  vpc = true
  tags = {
    Name = "NAT EIP"
  }
}
