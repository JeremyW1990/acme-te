output "asg_name" {
  description = "The name of the autoscaling group"
  value       = aws_autoscaling_group.asg.id
}

output "lb_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_lb.alb.dns_name
}