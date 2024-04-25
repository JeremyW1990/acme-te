resource "aws_security_group" "ec2_sg" {
  name_prefix = "ec2-sg-${var.name_suffix}"
  vpc_id      = var.vpc_id

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "EC2-Security-Group-${var.name_suffix}"
  }
}

resource "aws_launch_configuration" "this" {
  name_prefix     = "lc-${var.name_suffix}"
  image_id        = var.ami_id
  instance_type   = var.instance_type
  security_groups = [aws_security_group.ec2_sg.id]

  lifecycle {
    create_before_destroy = true
  }
}

resource "aws_autoscaling_group" "this" {
  name_prefix               = "asg-${var.name_suffix}"
  launch_configuration      = aws_launch_configuration.this.id
  min_size                  = var.asg_min_size
  max_size                  = var.asg_max_size
  desired_capacity          = var.asg_desired_capacity
  vpc_zone_identifier       = var.subnet_ids
  health_check_grace_period = 300
  force_delete              = true

  tag {
    key                 = "Name"
    value               = "ASG-EC2-${var.name_suffix}"
    propagate_at_launch = true
  }
}

resource "aws_alb" "this" {
  name_prefix     = "alb-"  # Shortened to conform with AWS requirements
  subnets         = var.subnet_ids
  security_groups = [aws_security_group.ec2_sg.id]

  tags = {
    Name = "ALB-${var.name_suffix}"
  }
}

resource "aws_alb_target_group" "this" {
  name_prefix = "tg-${var.name_suffix}"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = var.vpc_id
}

resource "aws_alb_listener" "front_end" {
  load_balancer_arn = aws_alb.this.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_alb_target_group.this.arn
  }
}