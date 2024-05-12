output "alb_dns_name" {
  value       = aws_alb.main.dns_name
  description = "DNS name of the application load balancer"
}