output "autoscaling_group_name" {
  description = "The name of the Auto Scaling Group"
  value       = aws_autoscaling_group.asg.id
}

output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer"
  value       = aws_alb.app_load_balancer.dns_name
}

output "load_balancer_zone_id" {
  description = "The zone ID of the load balancer"
  value       = aws_alb.app_load_balancer.zone_id
}