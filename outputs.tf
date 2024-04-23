output "vpc_id" {
  value = module.vpc.vpc_id
}

output "subnet_ids" {
  value = module.vpc.subnet_ids
}

output "alb_dns_name" {
  value = module.ec2.alb_dns_name
}

output "asg_name" {
  value = module.ec2.asg_name
}

# You can add more outputs needed to validate the deployment.