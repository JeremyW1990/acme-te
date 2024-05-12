output "alb_dns_name" {
  value       = aws_lb.alb.dns_name
  description = "The DNS name of the Application Load Balancer (ALB)"
}

output "asg_name" {
  value       = aws_autoscaling_group.asg.name
  description = "The name of the Autoscaling Group"
}