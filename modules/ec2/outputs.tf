output "launch_configuration_id" {
  description = "The ID of the launch configuration."
  value       = aws_launch_configuration.app_launch_configuration.id
}

output "autoscaling_group_id" {
  description = "The ID of the autoscaling group."
  value       = aws_autoscaling_group.app_autoscaling_group.id
}

output "load_balancer_dns_name" {
  description = "The DNS name of the load balancer."
  value       = aws_alb.app_load_balancer.dns_name
}

output "load_balancer_zone_id" {
  description = "The zone ID of the load balancer (used in Route 53)."
  value       = aws_alb.app_load_balancer.zone_id
}

output "security_group_id" {
  description = "The ID of the security group."
  value       = aws_security_group.app_security_group.id
}

output "target_group_arn" {
  description = "The ARN of the target group."
  value       = aws_alb_target_group.app_target_group.arn
}

output "listener_arn" {
  description = "The ARN of the listener."
  value       = aws_alb_listener.app_listener.arn
}