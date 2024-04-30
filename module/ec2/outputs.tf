output "alb_dns_name" {
    description = "The DNS name of the ALB"
    value       = aws_alb.app.dns_name
}

output "asg_name" {
    description = "The name of the Auto Scaling Group"
    value       = aws_autoscaling_group.app.name
}