variable "application_name" {
  description = "The name of the application for tagging and naming resources"
  type        = string
}
variable "vpc_id" {
  description = "The VPC ID where resources will be deployed"
  type        = string
}
variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
}
variable "instance_type" {
  description = "The type of EC2 instance to launch"
  type        = string
}
variable "subnets" {
  description = "The subnets for the ASG and ALB"
  type        = list(string)
}
variable "min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
}
variable "max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
}
variable "desired_capacity" {
  description = "Desired capacity of the Auto Scaling Group"
  type        = number
}
variable "user_data" {
  description = "The user data script to initialize the EC2 instances"
  type        = string
  default     = "#!/bin/bash\necho \"Auto Deployment from Cloud-AI\" > index.html"
}
variable "vpc_cidr" {
  description = "The CIDR block of the VPC"
  type        = string
}
