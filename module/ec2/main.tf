resource "aws_launch_configuration" "app" {
  name_prefix = "app-"
  image_id = var.ami_id
  instance_type = var.instance_type

  user_data = <<-EOF
              #!/bin/bash
              echo "Auto Deployment from Cloud-AI" > index.html
              nohup busybox httpd -f -p "${var.server_port}" -h . &
              EOF

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "app" {
  launch_configuration = aws_launch_configuration.app.id
  vpc_zone_identifier = var.subnet_ids

  min_size = var.asg_min_size
  max_size = var.asg_max_size

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }
}

resource "aws_security_group" "app" {
  name_prefix = "app-sg-"
  vpc_id = var.vpc_id

  ingress {
    from_port   = var.server_port
    to_port     = var.server_port
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

resource "aws_elb" "app" {
  name_prefix = "app-elb-"
  security_groups  = [aws_security_group.app.id]
  subnets          = var.subnet_ids

  listener {
    instance_port     = var.server_port
    instance_protocol = "http"
    lb_port           = 80
    lb_protocol       = "http"
  }

  health_check {
    healthy_threshold   = 2
    unhealthy_threshold = 2
    timeout             = 3
    target              = "HTTP:${var.server_port}/"
    interval            = 30
  }

  instances                   = aws_autoscaling_group.app.*.id
  cross_zone_load_balancing   = true
  idle_timeout                = 400
  connection_draining         = true
  connection_draining_timeout = 400

  tags = {
    Name = "app-load-balancer"
  }
}