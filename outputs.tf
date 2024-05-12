output "application_alb_dns_name" {
  value       = module.ec2.alb_dns_name
  description = "The DNS name for the application load balancer."
}

# We can add more outputs here if needed.