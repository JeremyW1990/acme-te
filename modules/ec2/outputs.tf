output "alb_arn" {
  value       = aws_alb.app_lb.arn
  description = "The ARN of the Application Load Balancer."
}

output "alb_dns_name" {
  value       = aws_alb.app_lb.dns_name
  description = "The DNS name of the Application Load Balancer."
}

output "asg_name" {
  value       = aws_autoscaling_group.app_asg.name
  description = "The name of the Auto Scaling group."
}

output "security_group_id" {
  value       = aws_security_group.ec2_sg.id
  description = "The ID of the security group for EC2 instances."
}

# Add more outputs as necessary for other resources.