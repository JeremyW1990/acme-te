output "alb_dns_name" {
  description = "The DNS name of the application load balancer"
  value       = aws_elb.app.dns_name
}

output "security_group_id" {
  description = "The ID of the security group"
  value       = aws_security_group.app.id
}