resource "aws_security_group" "ec2_sg" {
  name        = "ec2-sg"
  description = "Security group for EC2 instances in the autoscaling group"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80   # HTTP
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"  # Allow all outbound traffic
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_launch_configuration" "asg_lc" {
  name          = "asg-launch-configuration"
  image_id      = var.ami_id
  instance_type = var.instance_type
  security_groups = [aws_security_group.ec2_sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "asg" {
  launch_configuration = aws_launch_configuration.asg_lc.id
  vpc_zone_identifier  = var.subnets
  max_size             = var.max_size
  min_size             = var.min_size
  desired_capacity     = var.desired_capacity

  tag {
    key                 = "Name"
    value               = "asg-ec2-instance"
    propagate_at_launch = true
  }
}

resource "aws_lb" "alb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_sg.id]
  subnets            = var.public_subnets

  enable_deletion_protection = false

  tags = {
    Name = "app-lb"
  }
}

resource "aws_lb_target_group" "tg" {
  name     = "lb-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_lb_listener" "front_end" {
  load_balancer_arn = aws_lb.alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.tg.arn
  }
}