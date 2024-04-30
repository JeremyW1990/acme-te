output "alb_dns_name" {
  description = "The DNS name of the ALB for accessing the application"
  value       = aws_alb.alb.dns_name
}

output "asg_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.asg.id
}