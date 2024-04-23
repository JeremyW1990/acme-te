output "autoscaling_group_name" {
  description = "The name of the autoscaling group."
  value       = aws_autoscaling_group.app_asg.name
}

output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_lb.app_lb.dns_name
}

output "security_group_id" {
  description = "The ID of the security group."
  value       = aws_security_group.ec2_sg.id
}