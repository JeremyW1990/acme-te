output "vpc_id" {
  value       = aws_vpc.main.id
  description = "ID of the VPC created"
}

output "public_subnet_ids" {
  value       = aws_subnet.public[*].id
  description = "List of public subnet IDs"
}