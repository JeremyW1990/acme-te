output "vpc_id" {
  value       = module.vpc.vpc_id
  description = "The ID of the VPC created"
}

output "public_subnets" {
  value       = module.vpc.public_subnets
  description = "The IDs of the public subnets created"
}

output "asg_name" {
  value       = module.ec2.asg_name
  description = "The name of the Autoscaling Group"
}

output "alb_dns_name" {
  value       = module.ec2.alb_dns_name
  description = "The DNS name of the Application Load Balancer"
}