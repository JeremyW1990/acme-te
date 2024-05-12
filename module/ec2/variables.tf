variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the resources will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to launch resources in"
  type        = list(string)
}

variable "server_port" {
  description = "The port to use for the HTTP server"
  default     = 80
}

variable "asg_min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
}

variable "asg_max_size" {
  description = "The maximum size of the autoscaling group"
  type        = number
}

variable "asg_desired_capacity" {
  description = "The desired capacity of the autoscaling group"
  type        = number
}

variable "public_subnets" {
  description = "List of public subnets for the ALB"
  type        = list(string)
}