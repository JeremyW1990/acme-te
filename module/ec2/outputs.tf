output "alb_dns_name" {
  description = "DNS name of the application load balancer"
  value       = aws_alb.application_load_balancer.dns_name
}

output "asg_name" {
  description = "The autoscaling group name"
  value       = aws_autoscaling_group.asg.name
}