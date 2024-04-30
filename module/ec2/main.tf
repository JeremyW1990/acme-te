module "ec2" {
  source = "./module/ec2"

  # Autoscaling Configuration
  ami_id                = var.ami_id
  instance_type         = var.instance_type
  vpc_zone_identifier   = var.vpc_zone_identifier
  min_size              = var.min_size
  max_size              = var.max_size
  desired_capacity      = var.desired_capacity
  health_check_type     = var.health_check_type
  user_data             = var.user_data

  # ALB Configuration
  alb_subnets           = var.alb_subnets
  target_group_port     = var.target_group_port
  listener_port         = var.listener_port
}

# Security group for the EC2 instances
resource "aws_security_group" "ec2" {
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    to_port   = 80
    protocol  = "tcp"
    cidr_blocks = var.alb_subnet_cidrs
  }

  egress {
    from_port = 0
    to_port   = 0
    protocol  = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "ec2-instance-sg"
  }
}

# Load balancer and related resources
resource "aws_lb" "alb" {
  name               = "application-lb"
  load_balancer_type = "application"
  subnets            = var.alb_subnets

  tags = {
    Name = "Application Load Balancer"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "alb-target-group"
  port     = var.target_group_port
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  tags = {
    Name = "ALB Target Group"
  }
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.arn
  port              = var.listener_port
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}

# Launch configuration for EC2 instances
resource "aws_launch_configuration" "lc" {
  name          = "ec2-launch-configuration"
  image_id      = var.ami_id
  instance_type = var.instance_type
  user_data     = var.user_data

  security_groups = [aws_security_group.ec2.id]

  lifecycle {
    create_before_destroy = true
  }
}

# Autoscaling group configuration
resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.lc.name
  vpc_zone_identifier  = var.vpc_zone_identifier
  min_size             = var.min_size
  max_size             = var.max_size
  desired_capacity     = var.desired_capacity
  health_check_type    = var.health_check_type

  tag {
    key                 = "Name"
    value               = "ec2-instance"
    propagate_at_launch = true
  }
}
