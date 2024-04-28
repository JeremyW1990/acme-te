output "app_asg_name" {
  value       = aws_autoscaling_group.app_asg.name
  description = "The name of the autoscaling group."
}

output "app_load_balancer_dns_name" {
  value       = aws_elb.app_lb.dns_name
  description = "The DNS name of the application load balancer."
}

output "app_security_group_id" {
  value       = aws_security_group.app_sg.id
  description = "The ID of the application security group."
}