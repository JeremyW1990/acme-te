output "vpc_id" {
  value = module.vpc_module.vpc_id
}

output "private_subnets" {
  value = module.vpc_module.private_subnets
}

output "public_subnets" {
  value = module.vpc_module.public_subnets
}

output "autoscaling_group_name" {
  value = module.ec2_module.asg_name
}

output "load_balancer_dns_name" {
  value = module.ec2_module.lb_dns_name
}