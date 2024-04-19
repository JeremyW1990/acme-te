variable "vpc_id" {
  description = "The VPC ID where resources will be created"
}

variable "subnets" {
  description = "List of subnet IDs for the autoscaling group"
  type        = list(string)
}

variable "public_subnets" {
  description = "List of subnet IDs for the application load balancer"
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
}

variable "max_size" {
  description = "Maximum number of instances in the autoscaling group"
}

variable "min_size" {
  description = "Minimum number of instances in the autoscaling group"
}

variable "desired_capacity" {
  description = "Desired number of instances in the autoscaling group"
}