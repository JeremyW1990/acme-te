resource "aws_launch_configuration" "app" {
  name_prefix     = "app-launch-config-"
  image_id        = var.ami_id
  instance_type   = var.instance_type
  security_groups = [var.security_group_id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Auto Deployment from Cloud-AI" > /var/www/html/index.html
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app" {
  name_prefix     = "app-asg-"
  launch_configuration = aws_launch_configuration.app.id
  vpc_zone_identifier  = var.subnet_ids
  min_size             = var.asg_min_size
  max_size             = var.asg_max_size

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}

resource "aws_alb" "app" {
  name               = "app-alb"
  subnets            = var.subnet_ids
  security_groups    = [var.security_group_id]

  tags = {
    Name = "app-alb"
  }
}

resource "aws_alb_target_group" "app" {
  name     = "app-alb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_alb_listener" "app" {
  load_balancer_arn = aws_alb.app.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app.arn
  }
}