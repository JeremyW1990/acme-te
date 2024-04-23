variable "vpc_id" {
  description = "The VPC ID where resources will be created."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the autoscaling group and ALB."
  type        = list(string)
}

variable "application_name" {
  description = "Name of the application for tagging purposes."
  type        = string
}

variable "asg_desired_capacity" {
  description = "The desired capacity of the autoscaling group."
  type        = number
}

variable "asg_max_size" {
  description = "The maximum size of the autoscaling group."
  type        = number
}

variable "asg_min_size" {
  description = "The minimum size of the autoscaling group."
  type        = number
}

variable "ami_id" {
  description = "The ID of the AMI used by the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "Instance type of the EC2 instances."
  type        = string
}

# Add more variables for additional customization if required.