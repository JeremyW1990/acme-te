output "vpc_id" {
  description = "The ID of the VPC"
  value       = module.vpc.vpc_id
}

output "ec2_autoscaling_group_name" {
  description = "The name of the Auto Scaling Group"
  value       = module.ec2.autoscaling_group_name
}

output "alb_dns_name" {
  description = "The DNS name of the application load balancer"
  value       = module.ec2.load_balancer_dns_name
}