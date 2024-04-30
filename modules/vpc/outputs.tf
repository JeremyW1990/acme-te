output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC"
}

output "public_subnets" {
  value       = aws_subnet.public.*.id
  description = "List of public subnet IDs"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.gateway.id
  description = "The ID of the internet gateway"
}