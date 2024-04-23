resource "aws_launch_configuration" "lc" {
  name_prefix   = "lc-"
  image_id      = var.image_id
  instance_type = var.instance_type
  user_data     = file("${path.module}/user_data.sh")

  lifecycle {
    create_before_destroy = true
  }

  security_groups = [aws_security_group.sg.id]
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration    = aws_launch_configuration.lc.id
  vpc_zone_identifier     = var.subnets
  min_size                = var.asg_min_size
  max_size                = var.asg_max_size
  desired_capacity        = var.asg_desired_capacity
  health_check_type       = "EC2"
  force_delete            = true
  wait_for_capacity_timeout = "0"

  tag {
    key                 = "Name"
    value               = "ec2-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "sg" {
  name_prefix = "sg-"
  description = "Security group for the application"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = var.app_port
    to_port     = var.app_port
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

resource "aws_alb" "alb" {
  name_prefix   = "alb-"
  subnets       = var.subnets
  security_groups = [aws_security_group.sg.id]

  tags = {
    Name = "alb"
  }
}

resource "aws_alb_target_group" "tg" {
  name_prefix   = "tg-"
  port          = var.app_port
  protocol      = "HTTP"
  vpc_id        = var.vpc_id

  health_check {
    path                = var.health_check_path
    protocol            = "HTTP"
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 5
    interval            = 30
    matcher             = "200"
  }
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg.arn
  }
}