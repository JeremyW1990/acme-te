output "vpc_id" {
  value = module.vpc.vpc_id
}

output "public_subnets" {
  value = module.vpc.public_subnets
}

output "internet_gateway_id" {
  value = module.vpc.internet_gateway_id
}

output "alb_dns_name" {
  value = module.ec2.alb_dns_name
}