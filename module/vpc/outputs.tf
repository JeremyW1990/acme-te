output "vpc_id" {
  description = "The ID of the VPC."
  value       = aws_vpc.main.id
}

output "public_subnets" {
  description = "The IDs of the public subnets."
  value       = aws_subnet.public[*].id
}

output "internet_gateway" {
  description = "The ID of the internet gateway."
  value       = aws_internet_gateway.gw.id
}