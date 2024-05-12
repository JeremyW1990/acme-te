resource "aws_vpc" "example" {
  cidr_block           = var.cidr_block
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = {
    Name = "cloud-ai-vpc"
  }
}

resource "aws_subnet" "example" {
  vpc_id                  = aws_vpc.example.id
  cidr_block              = element(var.subnet_cidr_blocks, count.index)
  availability_zone       = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  count = length(var.subnet_cidr_blocks)

  tags = {
    Name = "cloud-ai-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "example" {
  vpc_id = aws_vpc.example.id

  tags = {
    Name = "cloud-ai-igw"
  }
}

resource "aws_route_table" "example" {
  vpc_id = aws_vpc.example.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.example.id
  }

  tags = {
    Name = "cloud-ai-route-table"
  }
}

resource "aws_route_table_association" "example" {
  count = length(aws_subnet.example)

  subnet_id      = aws_subnet.example[count.index].id
  route_table_id = aws_route_table.example.id
}