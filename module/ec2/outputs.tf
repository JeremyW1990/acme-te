output "alb_dns_name" {
  description = "The DNS name of the application load balancer."
  value       = aws_alb.app_alb.dns_name
}