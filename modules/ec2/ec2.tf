resource "aws_security_group" "ec2_sg" {
  name        = "ec2-security-group"
  description = "Security Group for EC2 instances"
  vpc_id      = var.vpc_id
}

# Assume this security group allows for HTTP and SSH access.
# This is just an example. Modify the rules as necessary for your actual requirements.
resource "aws_security_group_rule" "allow_http" {
  type        = "ingress"
  from_port   = 80
  to_port     = 80
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
}

resource "aws_security_group_rule" "allow_ssh" {
  type        = "ingress"
  from_port   = 22
  to_port     = 22
  protocol    = "tcp"
  cidr_blocks = ["0.0.0.0/0"]
  security_group_id = aws_security_group.ec2_sg.id
}

# Setup an application load balancer
resource "aws_lb" "app_lb" {
  name               = "app-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.ec2_sg.id]
  subnets            = var.subnet_ids

  enable_deletion_protection = false

  tags = merge(
    var.tags,
    {
      Name = "app-lb"
    },
  )
}

# Launch configuration for autoscaling group
resource "aws_launch_configuration" "app_lc" {
  name_prefix          = "app-lc-"
  image_id             = var.ami_id
  instance_type        = var.instance_type
  security_groups      = [aws_security_group.ec2_sg.id]
  key_name             = var.key_name
  user_data            = var.user_data

  lifecycle {
    create_before_destroy = true
  }
}

# Autoscaling group
resource "aws_autoscaling_group" "app_asg" {
  launch_configuration = aws_launch_configuration.app_lc.id
  vpc_zone_identifier  = var.subnet_ids
  desired_capacity     = var.desired_capacity
  min_size             = var.min_size
  max_size             = var.max_size

  tag {
    key                 = "Name"
    value               = "app-instance"
    propagate_at_launch = true
  }

  tags = [
    for k, v in var.tags : {
      key                 = k
      value               = v
      propagate_at_launch = true
    }
  ]
}

# ... Attach app_asg to app_lb, configure listeners and target groups