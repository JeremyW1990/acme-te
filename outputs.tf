output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "ID of the VPC created by the VPC module"
}

output "public_subnet_ids" {
  value       = module.vpc.public_subnet_ids
  description = "List of public subnet IDs created by the VPC module"
}

output "ec2_alb_dns_name" {
  value       = module.ec2.alb_dns_name
  description = "DNS name of the application load balancer created by the EC2 module"
}