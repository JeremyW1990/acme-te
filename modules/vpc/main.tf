resource "aws_vpc" "this" {
  cidr_block = var.vpc_cidr

  tags = {
    Name = "VPC-${var.name_suffix}"
  }
}

resource "aws_subnet" "public" {
  count             = length(var.public_subnets_cidr)
  vpc_id            = aws_vpc.this.id
  cidr_block        = element(var.public_subnets_cidr, count.index)
  availability_zone = element(var.availability_zones, count.index)

  tags = {
    Name = "Public-Subnet-${count.index}-${var.name_suffix}"
  }
}

resource "aws_internet_gateway" "this" {
  vpc_id = aws_vpc.this.id

  tags = {
    Name = "Internet-Gateway-${var.name_suffix}"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.this.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.this.id
  }

  tags = {
    Name = "Public-Route-Table-${var.name_suffix}"
  }
}

# Associate public route table with public subnets
resource "aws_route_table_association" "public" {
  count          = length(var.public_subnets_cidr)
  subnet_id      = element(aws_subnet.public.*.id, count.index)
  route_table_id = aws_route_table.public.id
}