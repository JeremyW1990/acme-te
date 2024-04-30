variable "vpc_id" {
  type        = string
  description = "The VPC ID where resources will be deployed"
}

variable "subnets" {
  type        = list(string)
  description = "The subnets for the autoscaling group"
}

variable "ami_id" {
  type        = string
  description = "The AMI ID to use for the instances"
}

variable "instance_type" {
  type        = string
  description = "Instance type to use for the EC2 instances"
}

variable "app_name" {
  type        = string
  description = "Name of the application for tagging"
}

variable "alb_security_group_name" {
  type        = string
  description = "Name of the security group for the ALB"
}

variable "ec2_security_group_name" {
  type        = string
  description = "Name of the security group for the EC2 instances"
}

variable "asg_min_size" {
  type        = number
  description = "Minimum size of the autoscaling group"
}

variable "asg_max_size" {
  type        = number
  description = "Maximum size of the autoscaling group"
}

variable "asg_desired_capacity" {
  type        = number
  description = "Desired size of the autoscaling group"
}

variable "server_port" {
  type        = number
  default     = 80
  description = "The port the server will use for HTTP requests"
}