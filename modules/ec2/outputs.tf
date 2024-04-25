output "asg_name" {
  value       = aws_autoscaling_group.asg.id
  description = "The name of the Autoscaling Group"
}

output "alb_arn" {
  value       = aws_alb.app_lb.arn
  description = "The ARN of the Application Load Balancer"
}

output "alb_dns_name" {
  value       = aws_alb.app_lb.dns_name
  description = "The DNS name of the Application Load Balancer"
}

output "security_group_id" {
  value       = aws_security_group.ec2_sg.id
  description = "The ID of the Security Group for the EC2 instances"
}