resource "aws_security_group" "main" {
  name        = "${var.application_name}-sg"
  description = "Security group for ${var.application_name}"
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

resource "aws_launch_configuration" "main" {
  name_prefix     = "${var.application_name}-lc"
  image_id        = var.ami_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.main.id]

  user_data = <<-EOF
              #!/bin/bash
              echo "Welcome to nginx" > /usr/share/nginx/html/index.html
              echo "Auto Deployment from Cloud-AI" >> /usr/share/nginx/html/index.html
              service nginx start
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "main" {
  name_prefix           = "${var.application_name}-asg"
  launch_configuration  = aws_launch_configuration.main.id
  vpc_zone_identifier   = var.subnets
  min_size              = var.asg_min_size
  max_size              = var.asg_max_size

  tag {
    key                 = "Name"
    value               = "${var.application_name}-instance"
    propagate_at_launch = true
  }
}

resource "aws_alb" "main" {
  name               = "${var.application_name}-alb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.main.id]
  subnets            = var.subnets

  enable_deletion_protection = false

  tags = {
    Name = "${var.application_name}-alb"
  }
}

resource "aws_alb_target_group" "main" {
  name     = "${var.application_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id
}

resource "aws_alb_listener" "main" {
  load_balancer_arn = aws_alb.main.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.main.arn
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.main.id
  alb_target_group_arn   = aws_alb_target_group.main.arn
}