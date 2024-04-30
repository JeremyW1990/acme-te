output "alb_dns_name" {
  description = "The DNS name of the ALB"
  value       = aws_lb.alb.dns_name
}

output "alb_zone_id" {
  description = "The zone ID of the ALB"
  value       = aws_lb.alb.zone_id
}

output "asg_name" {
  description = "The name of the autoscaling group"
  value       = aws_autoscaling_group.asg.id
}
