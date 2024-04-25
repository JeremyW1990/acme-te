variable "name_suffix" {
  description = "A suffix to append to resources names to ensure uniqueness"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where resources will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for the ALB and Autoscaling Group"
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string
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