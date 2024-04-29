output "application_url" {
  description = "URL to access the application."
  value       = "http://${module.ec2.alb_dns_name}/"
}