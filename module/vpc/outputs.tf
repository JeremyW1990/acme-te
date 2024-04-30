output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the VPC"
}

output "public_subnets_ids" {
  value       = aws_subnet.public.*.id
  description = "List of IDs of the public subnets"
}

output "internet_gateway_id" {
  value       = aws_internet_gateway.gw.id
  description = "ID of the Internet Gateway"
}