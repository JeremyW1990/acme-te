resource "aws_security_group" "alb_sg" {
  name_prefix = "alb-sg-"
  vpc_id      = var.vpc_id

  # Allow inbound HTTP traffic
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Default rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "Application Load Balancer SG"
  }
}

resource "aws_security_group" "ec2_sg" {
  name_prefix = "ec2-sg-"
  vpc_id      = var.vpc_id

  # Allow inbound SSH traffic for management
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Example rule: allow inbound HTTP traffic from the ALB only
  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb_sg.id]
  }

  # Default rule to allow all outbound traffic
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2 Instances SG"
  }
}

resource "aws_launch_configuration" "app" {
  name_prefix     = "app-lc-"
  image_id        = var.ami_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.ec2_sg.id]

  lifecycle {
    create_before_destroy = true
  }

  user_data = <<-EOF
              #!/bin/bash
              echo "Auto Deployment from Cloud-AI" > index.html
              nohup busybox httpd -f -p 80 -h . &
              EOF
}

resource "aws_autoscaling_group" "app" {
  launch_configuration    = aws_launch_configuration.app.id
  vpc_zone_identifier     = var.subnet_ids
  min_size                = var.min_size
  max_size                = var.max_size
  desired_capacity        = var.desired_capacity
  health_check_type       = "EC2"
  force_delete            = true
  wait_for_capacity_timeout = "0"

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}

resource "aws_alb" "main" {
  name_prefix = "app-alb-"
  subnets     = var.subnet_ids
  security_groups = [aws_security_group.alb_sg.id]

  tags = {
    Name = "Application Load Balancer"
  }
}

resource "aws_alb_target_group" "app_tg" {
  name_prefix = "app-tg-"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    protocol            = "HTTP"
    timeout             = 3
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200-299"
  }

  # Target type can also be `ip` or `lambda` based on your architecture.
  target_type = "instance"
}

resource "aws_alb_listener" "app_listener" {
  load_balancer_arn = aws_alb.main.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app_tg.arn
  }
}