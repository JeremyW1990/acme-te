output "security_group_id" {
  description = "The ID of the security group for EC2 instances"
  value       = aws_security_group.ec2_sg.id
}

output "autoscaling_group_name" {
  description = "The name of the autoscaling group for EC2 instances"
  value       = aws_autoscaling_group.as_group.name
}

output "lb_dns_name" {
  description = "The DNS name of the application load balancer"
  value       = aws_lb.app_lb.dns_name
}