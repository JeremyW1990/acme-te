resource "aws_launch_configuration" "app" {
  name_prefix          = "cloud-ai-launch-configuration-"
  image_id             = var.ami_id
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.app_sg.id]
  user_data            = file("${path.module}/user_data.sh")
  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app_asg" {
  launch_configuration    = aws_launch_configuration.app.id
  vpc_zone_identifier     = var.public_subnets
  min_size                = var.asg_min_size
  max_size                = var.asg_max_size
  desired_capacity        = var.asg_desired_capacity
  health_check_type       = "EC2"
  force_delete            = true
  wait_for_capacity_timeout = "0"

  tag {
    key                 = "Name"
    value               = "cloud-ai-asg-instance"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "app_sg" {
  name_prefix = "cloud-ai-app-sg-"
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

resource "aws_alb" "app_alb" {
  name               = "cloud-ai-app-alb"
  subnets            = var.public_subnets
  security_groups    = [aws_security_group.app_sg.id]

  tags = {
    Name = "cloud-ai-app-load-balancer"
  }
}

resource "aws_alb_target_group" "app_tg" {
  name        = "cloud-ai-app-tg"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id

  health_check {
    path               = "/"
    interval           = 30
    timeout            = 5
    healthy_threshold   = 2
    unhealthy_threshold = 2
  }
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.app_alb.id
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app_tg.arn
  }
}