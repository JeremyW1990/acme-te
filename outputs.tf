output "application_load_balancer_dns" {
  description = "The DNS name of the application load balancer"
  value       = module.ec2.alb_dns_name
}