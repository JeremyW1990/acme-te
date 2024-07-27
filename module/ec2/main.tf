resource "aws_launch_configuration" "app" {
  name_prefix          = "${var.name}-config-"
  image_id             = var.ami_id
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.asg.id]
  user_data            = data.template_file.user_data.rendered
  enable_monitoring    = var.enable_monitoring

  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "user_data" {
  template = <<-EOF
              #!/bin/bash
              echo "Auto Deployment from Cloud-AI" > /var/www/html/index.html
              EOF
}

resource "aws_security_group" "asg" {
  name_prefix = "${var.name}-asg-"
  description = "Security group for autoscaling group"
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

resource "aws_autoscaling_group" "asg" {
  launch_configuration    = aws_launch_configuration.app.id
  vpc_zone_identifier     = var.subnets
  min_size                = var.asg_min_size
  max_size                = var.asg_max_size
  desired_capacity        = var.asg_desired_capacity
  health_check_type       = "EC2"
  health_check_grace_period = 300
  tag {
    key                 = "Name"
    value               = "${var.name}-instance"
    propagate_at_launch = true
  }
}

resource "aws_alb" "app_load_balancer" {
  name               = "${var.name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb.id]
  subnets            = var.public_subnets

  enable_deletion_protection = false
}

resource "aws_security_group" "alb" {
  name_prefix = "${var.name}-alb-"
  description = "Security group for the application load balancer"
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

resource "aws_alb_target_group" "app_target_group" {
  name     = "${var.name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_alb_listener" "app_listener" {
  load_balancer_arn = aws_alb.app_load_balancer.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app_target_group.arn
  }
}