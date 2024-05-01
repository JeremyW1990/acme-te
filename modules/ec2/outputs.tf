output "alb_dns_name" {
  description = "The DNS name of the application load balancer."
  value       = aws_alb.app.dns_name
}

output "asg_name" {
  description = "The name of the autoscaling group."
  value       = aws_autoscaling_group.app.name
}