output "asg_name" {
  description = "The name of the Autoscaling Group"
  value       = aws_autoscaling_group.asg.name
}

output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_lb.alb.dns_name
}

output "alb_listener_arn" {
  description = "The ARN of the ALB Listener"
  value       = aws_lb_listener.alb_listener.arn
}