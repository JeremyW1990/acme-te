# ...previous resources...

resource "aws_alb" "alb" {
  name               = "${var.application_name}-alb"
  subnets            = var.subnets
  security_groups    = [aws_security_group.alb_sg.id]
  internal           = false
  load_balancer_type = "application"

  tags = {
    Name = "${var.application_name}-alb"
  }
}

resource "aws_alb_target_group" "target_group" {
  name     = "${var.application_name}-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = var.vpc_id

  health_check {
    interval            = 30
    path                = "/"
    timeout             = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
    matcher             = "200"
  }

  tags = {
    Name = "${var.application_name}-tg"
  }
}

resource "aws_alb_listener" "listener" {
  load_balancer_arn = aws_alb.alb.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.target_group.arn
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name = aws_autoscaling_group.asg.id
  alb_target_group_arn   = aws_alb_target_group.target_group.arn
}

# User data script to set up a simple homepage with a message
resource "aws_launch_configuration" "launch_config" {
  # ...existing configuration...

  user_data = <<-EOF
              #!/bin/bash
              echo "Auto Deployment from Cloud-AI" > /var/www/html/index.html
              EOF

  lifecycle {
    create_before_destroy = true
  }
}