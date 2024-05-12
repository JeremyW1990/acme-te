resource "aws_security_group" "alb" {
  name        = "alb-security-group"
  description = "Security group for ALB"
  vpc_id      = var.vpc_id
}

resource "aws_launch_configuration" "asg_config" {
  name_prefix   = "asg-config-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  user_data     = data.template_file.user_data.rendered

  security_groups = [aws_security_group.alb.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name_prefix             = "asg-"
  launch_configuration    = aws_launch_configuration.asg_config.id
  min_size                = var.min_size
  max_size                = var.max_size
  desired_capacity        = var.desired_capacity
  vpc_zone_identifier     = var.subnets
  health_check_type       = "ELB"
  wait_for_elb_capacity   = var.min_size

  tag {
    key                 = "Name"
    value               = "CloudAI-ASG-Instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_alb" "application_load_balancer" {
  name               = "alb-cloudai"
  subnets            = var.subnets
  security_groups    = [aws_security_group.alb.id]

  # Specify the type here if needed, defaults to "application"
  # type = "application"

  enable_deletion_protection = false

  tags = {
    Name = "CloudAI-ALB"
  }
}

data "template_file" "user_data" {
  template = <<-EOF
              #!/bin/bash
              echo "Auto Deployment from Cloud-AI" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF
}

resource "aws_alb_target_group" "alb_target_group" {
  name     = "alb-target-group"
  port     = var.server_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_alb_listener" "alb_listener" {
  load_balancer_arn = aws_alb.application_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.alb_target_group.arn
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  lb_target_group_arn    = aws_alb_target_group.alb_target_group.arn
}

# ... (other configuration remains unchanged)