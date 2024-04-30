output "alb_dns_name" {
  description = "The DNS name for the ALB to access the application"
  value       = module.my_ec2.alb_dns_name
}