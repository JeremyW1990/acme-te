output "alb_dns_name" {
  value       = aws_alb.main.dns_name
  description = "The DNS name of the application load balancer"
}

output "app_security_group_id" {
  value       = aws_security_group.ec2_sg.id
  description = "The security group ID for the application EC2 instances"
}