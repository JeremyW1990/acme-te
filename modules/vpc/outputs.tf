output "vpc_id" {
  value       = aws_vpc.example.id
  description = "The ID of the VPC"
}

output "subnet_ids" {
  value       = aws_subnet.example[*].id
  description = "The IDs of the subnets"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.example.id
  description = "The ID of the Internet Gateway"
}