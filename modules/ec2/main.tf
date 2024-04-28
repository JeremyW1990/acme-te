resource "aws_launch_configuration" "app" {
  name_prefix            = "app-"
  image_id               = var.ami_id
  instance_type          = var.instance_type
  user_data              = file("${path.module}/user_data.sh")
  security_groups        = [aws_security_group.app_sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app_asg" {
  launch_configuration    = aws_launch_configuration.app.id
  vpc_zone_identifier     = var.subnets
  max_size                = var.asg_max_size
  min_size                = var.asg_min_size
  desired_capacity        = var.asg_desired_capacity
  health_check_type       = "ELB"
  load_balancers          = [aws_elb.app_lb.name]
  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "app_sg" {
  name        = "app-sg"
  description = "Security group for App instances"
  vpc_id      = var.vpc_id

  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_elb" "app_lb" {
  name               = "app-load-balancer"
  subnets            = var.subnets
  security_groups    = [aws_security_group.app_sg.id]

  listener {
    instance_port     = 80
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    interval            = 30
    target              = "HTTP:80/"
  }
}