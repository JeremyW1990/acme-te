resource "aws_security_group" "ec2_sg" {
  name        = "cloud-ai-ec2-sg"
  description = "Security group for EC2 instances"
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

resource "aws_launch_configuration" "as_config" {
  name_prefix          = "cloud-ai-launch-config-"
  image_id             = var.ami_id
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.ec2_sg.id]
  user_data_base64     = base64encode(var.userdata_script)

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "as_group" {
  launch_configuration    = aws_launch_configuration.as_config.id
  vpc_zone_identifier     = var.subnets
  min_size                = var.autoscaling_min_size
  max_size                = var.autoscaling_max_size
  desired_capacity        = var.autoscaling_desired_capacity
  health_check_type       = "EC2"
  health_check_grace_period = 300
  force_delete            = true
  wait_for_capacity_timeout = "0"

  tag {
    key                 = "Name"
    value               = "cloud-ai-ec2-instance"
    propagate_at_launch = true
  }
}

resource "aws_lb" "app_lb" {
  name               = "cloud-ai-app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_sg.id]
  subnets            = var.subnets

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "app_lb_tg" {
  name     = "cloud-ai-app-lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "app_lb_listener" {
  load_balancer_arn = aws_lb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.app_lb_tg.arn
  }
}

resource "aws_autoscaling_attachment" "as_lb_attachment" {
  autoscaling_group_name = aws_autoscaling_group.as_group.name
  lb_target_group_arn    = aws_lb_target_group.app_lb_tg.arn
}