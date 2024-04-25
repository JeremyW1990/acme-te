output "alb_dns_name" {
  description = "The DNS name of the Application Load Balancer"
  value       = aws_alb.this.dns_name
}

output "asg_name" {
  description = "The name of the Autoscaling Group"
  value       = aws_autoscaling_group.this.name
}