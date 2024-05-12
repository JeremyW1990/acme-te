resource "aws_security_group" "asg_security_group" {
  name        = "cloud-ai-asg-sg"
  description = "Security group for Autoscaling Group EC2 instances"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = [var.alb_access_cidr]
  }
}

resource "aws_launch_configuration" "asg_launch_configuration" {
  name_prefix                 = "cloud-ai-launch-configuration-"
  image_id                    = var.ami_id
  instance_type               = var.instance_type
  security_groups             = [aws_security_group.asg_security_group.id]
  user_data                   = file("${path.module}/userdata.sh")
  associate_public_ip_address = true

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name_prefix           = "cloud-ai-asg-"
  launch_configuration  = aws_launch_configuration.asg_launch_configuration.id
  vpc_zone_identifier   = var.subnet_ids
  min_size              = var.asg_min_size
  max_size              = var.asg_max_size
  desired_capacity      = var.asg_desired_capacity
  health_check_type     = "EC2"

  tag {
    key                 = "Name"
    value               = "cloud-ai-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_lb" "alb" {
  name               = "cloud-ai-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.asg_security_group.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "asg_target_group" {
  name     = "cloud-ai-target-group"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    protocol            = "HTTP"
    matcher             = "200-299"
  }
}

resource "aws_lb_listener" "alb_listener" {
  load_balancer_arn = aws_lb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.asg_target_group.arn
  }
}