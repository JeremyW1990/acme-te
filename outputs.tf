output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnet_ids" {
  value = module.vpc.public_subnet_ids
}

output "alb_dns_name" {
  value = module.ec2.alb_dns_name
}

output "asg_name" {
  value = module.ec2.asg_name
}