resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security Group for EC2 instances"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Ingress rules can be set based on specific requirements
}

resource "aws_launch_configuration" "asg_config" {
  name          = "asg-config"
  image_id      = var.image_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.ec2_sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  name                 = "asg-${var.environment}"
  launch_configuration = aws_launch_configuration.asg_config.id
  vpc_zone_identifier  = var.subnet_ids
  min_size             = var.asg_min_size
  max_size             = var.asg_max_size
  desired_capacity     = var.asg_desired_capacity

  tag {
    key                 = "Name"
    value               = "asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_alb" "app_lb" {
  name               = "app-alb-${var.environment}"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_sg.id]
  subnets            = var.subnet_ids

  tags {
    Name        = "app-alb"
    Environment = var.environment
  }
}

resource "aws_alb_target_group" "tg" {
  name     = "app-tg-${var.environment}"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.tg.arn
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  alb_target_group_arn   = aws_alb_target_group.tg.arn
}