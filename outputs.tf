output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "alb_dns_name" {
  value = module.ec2.alb_dns_name
}

output "autoscaling_group_name" {
  value = module.ec2.asg_name
}