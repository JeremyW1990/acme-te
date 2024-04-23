output "asg_name" {
  value = aws_autoscaling_group.asg.name
}

output "alb_dns_name" {
  value = aws_alb.alb.dns_name
}

output "alb_target_group_arn" {
  value = aws_alb_target_group.tg.arn
}

output "sg_id" {
  value = aws_security_group.sg.id
}