variable "vpc_id" {
  description = "The VPC ID where the resources will be deployed."
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs for the Autoscaling Group and ALB."
  type        = list(string)
}

variable "image_id" {
  description = "The image ID to be used for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "The instance type of the EC2 instances."
  type        = string
}

variable "asg_min_size" {
  description = "Minimum size of the Autoscaling Group."
  type        = number
}

variable "asg_max_size" {
  description = "Maximum size of the Autoscaling Group."
  type        = number
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the Autoscaling Group."
  type        = number
}

variable "environment" {
  description = "The environment tag for the resources."
  type        = string
}