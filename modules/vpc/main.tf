resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = "main-vpc"
  }
}

resource "aws_subnet" "public" {
  count = length(var.public_subnets_cidr)

  vpc_id            = aws_vpc.main.id
  cidr_block        = var.public_subnets_cidr[count.index]
  availability_zone = element(var.availability_zones, count.index)
  map_public_ip_on_launch = true

  tags = {
    Name = "public-subnet-${count.index}"
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Name = "main-igw"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "public-route-table"
  }
}

resource "aws_route_table_association" "public" {
  count = length(var.public_subnets_cidr)

  subnet_id      = aws_subnet.public[count.index].id
  route_table_id = aws_route_table.public.id
}