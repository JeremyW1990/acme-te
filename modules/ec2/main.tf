resource "aws_launch_configuration" "app" {
  name_prefix          = "lc-${var.application_name}-"
  image_id             = var.ami_id
  instance_type        = var.instance_type
  user_data            = data.template_file.user_data.rendered
  security_groups      = [aws_security_group.app.id]
  lifecycle {
    create_before_destroy = true
  }
}

data "template_file" "user_data" {
  template = file("${path.module}/user_data.sh")
  
  vars = {
    server_text = var.server_text
  }
}

resource "aws_security_group" "app" {
  name_prefix = "sg-${var.application_name}-"
  vpc_id      = var.vpc_id

  ingress {
    description = "Allow traffic from ALB"
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    security_groups = [aws_security_group.alb.id]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_autoscaling_group" "app" {
  name_prefix           = "asg-${var.application_name}-"
  launch_configuration  = aws_launch_configuration.app.name
  min_size              = var.asg_min_size
  max_size              = var.asg_max_size
  desired_capacity      = var.asg_desired_capacity
  vpc_zone_identifier   = var.subnet_ids
  health_check_type     = "EC2"
  force_delete          = true
  wait_for_capacity_timeout = "0"
  
  tag {
    key                 = "Name"
    value               = "${var.application_name}-instance"
    propagate_at_launch = true
  }

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_security_group" "alb" {
  name_prefix = "alb-sg-${var.application_name}-"
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

resource "aws_alb" "app" {
  name_prefix          = "alb-${var.application_name}-"
  internal             = false
  load_balancer_type   = "application"
  security_groups      = [aws_security_group.alb.id]
  subnets              = var.subnet_ids
  enable_deletion_protection = false

  tags = {
    Name = "app-load-balancer"
  }
}

resource "aws_alb_target_group" "app" {
  name_prefix      = "tg-${var.application_name}-"
  port             = 80
  protocol         = "HTTP"
  vpc_id           = var.vpc_id
  target_type      = "instance"

  health_check {
    path                = "/"
    protocol            = "HTTP"
    matcher             = "200"
  }

  tags = {
    Name = "app-target-group"
  }
}

resource "aws_alb_listener" "http" {
  load_balancer_arn = aws_alb.app.arn
  port              = 80
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.app.arn
  }
}

resource "aws_autoscaling_attachment" "asg_attachment" {
  autoscaling_group_name   = aws_autoscaling_group.app.id
  alb_target_group_arn     = aws_alb_target_group.app.arn
}
