resource "aws_security_group" "alb_sg" {
  name        = var.alb_security_group_name
  description = "Security Group for ALB"
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

resource "aws_security_group" "ec2_sg" {
  name        = var.ec2_security_group_name
  description = "Security Group for EC2 Instances"
  vpc_id      = var.vpc_id

  # Allow inbound HTTP from ALB
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "ec2_lc" {
  name_prefix   = "lc-${var.app_name}-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.ec2_sg.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Hello, Cloud-AI!" > index.html
              nohup busybox httpd -f -p ${var.server_port} &
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "ec2_asg" {
  launch_configuration    = aws_launch_configuration.ec2_lc.id
  vpc_zone_identifier     = var.subnets
  min_size                = var.asg_min_size
  max_size                = var.asg_max_size
  desired_capacity        = var.asg_desired_capacity
  health_check_type       = "EC2"
  health_check_grace_period = 300
  force_delete            = true
  target_group_arns       = [aws_lb_target_group.asg_tg.arn]

  tag {
    key                 = "Name"
    value               = var.app_name
    propagate_at_launch = true
  }
}

resource "aws_lb" "alb" {
  name               = "alb-${var.app_name}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb_sg.id]
  subnets            = var.subnets

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "asg_tg" {
  name        = "tg-${var.app_name}"
  port        = var.server_port
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
  target_type = "instance"

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg_tg.arn
  }
}