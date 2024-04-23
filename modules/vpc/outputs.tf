output "vpc_id" {
  value       = aws_vpc.main.id
  description = "The ID of the VPC."
}

output "subnet_ids" {
  value       = aws_subnet.main[*].id
  description = "The IDs of the subnets."
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.gw.id
  description = "The ID of the Internet Gateway."
}

output "public_route_table_id" {
  value       = aws_route_table.public.id
  description = "The ID of the public route table."
}

# Add more outputs as necessary for resources like private subnets, NAT gateways, etc.