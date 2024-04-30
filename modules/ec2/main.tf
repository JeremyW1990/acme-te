resource "aws_launch_configuration" "app_launch_configuration" {
  name_prefix = "app-lc-"
  image_id    = var.ami_id
  instance_type = var.instance_type
  
  user_data = base64encode(<<-EOF
              #!/bin/bash
              echo "Auto Deployment from Cloud-AI" > /var/www/html/index.html
              EOF
              )

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "app_security_group" {
  name_prefix = "app-sg-"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_autoscaling_group" "app_autoscaling_group" {
  launch_configuration = aws_launch_configuration.app_launch_configuration.id
  vpc_zone_identifier  = var.subnet_ids
  min_size = var.min_size
  max_size = var.max_size

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}

resource "aws_alb" "app_load_balancer" {
  name_prefix = "app-alb-"
  subnets     = var.subnet_ids
  security_groups = [aws_security_group.app_security_group.id]

  enable_deletion_protection = false

  tags = {
    Name = "app-load-balancer"
  }
}

resource "aws_alb_target_group" "app_target_group" {
  name_prefix = "app-tg-"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    path               = "/"
    interval           = 30
    timeout            = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }

  tags = {
    Name = "app-target-group"
  }
}

resource "aws_alb_listener" "app_listener" {
  load_balancer_arn = aws_alb.app_load_balancer.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app_target_group.arn
  }
}