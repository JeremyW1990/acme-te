variable "application_name" {
  description = "The name of the application."
  type        = string
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "The instance type of the EC2 instances."
  type        = string
}

variable "asg_min_size" {
  description = "The minimum size of the autoscaling group."
  type        = number
}

variable "asg_max_size" {
  description = "The maximum size of the autoscaling group."
  type        = number
}

variable "asg_desired_capacity" {
  description = "The desired capacity of the autoscaling group."
  type        = number
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch resources in."
  type        = list(string)
}

variable "vpc_id" {
  description = "The ID of the VPC to launch resources in."
  type        = string
}

variable "server_text" {
  description = "The text to display on the server's home page."
  type        = string
  default     = "Auto Deployment from Cloud-AI"
}