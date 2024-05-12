output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets_ids" {
  value = module.vpc.public_subnets
}

output "application_load_balancer_dns" {
  value = module.ec2.lb_dns_name
}