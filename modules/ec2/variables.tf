variable "vpc_id" {
  description = "The VPC ID where resources will be created"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the autoscaling group and ALB"
  type        = list(string)
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "EC2 instance type for the launch configuration"
  type        = string
  default     = "t2.micro"
}

variable "min_size" {
  description = "Minimum size of the autoscaling group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "Maximum size of the autoscaling group"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "Desired capacity of the autoscaling group"
  type        = number
  default     = 1
}