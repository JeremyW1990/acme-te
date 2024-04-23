# Security group for the EC2 instances
resource "aws_security_group" "ec2_sg" {
  name        = "${var.application_name}-sg"
  description = "Security group for EC2 instances"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  # Add your ingress rules here
}

# Application Load Balancer
# Create an ALB, Target Group, Listener and Listener Rules depending on your application needs.

resource "aws_alb" "app_lb" {
  name               = "${var.application_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_sg.id]
  subnets            = var.subnet_ids

  tags = {
    Name = "${var.application_name}-alb"
  }
}

resource "aws_alb_target_group" "app_tg" {
  name     = "${var.application_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_alb_listener" "app_listener" {
  load_balancer_arn = aws_alb.app_lb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app_tg.arn
  }
}

# Autoscaling Group
resource "aws_autoscaling_group" "app_asg" {
  desired_capacity     = var.asg_desired_capacity
  max_size             = var.asg_max_size
  min_size             = var.asg_min_size
  vpc_zone_identifier  = var.subnet_ids
  health_check_type    = "EC2"
  force_delete         = true
  launch_configuration = aws_launch_configuration.app_lc.name
  target_group_arns    = [aws_alb_target_group.app_tg.arn]
}

resource "aws_launch_configuration" "app_lc" {
  name_prefix   = "${var.application_name}-lc-"
  image_id      = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.ec2_sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

# Add additional configurations like IAM roles, detailed monitoring, etc., as needed.