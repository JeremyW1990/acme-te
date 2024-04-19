variable "aws_region" {
  description = "AWS region where resources will be created"
  default     = "us-east-1"
}

variable "availability_zones" {
  description = "List of availability zones in the region"
  type        = list(string)
}

variable "private_subnets_cidr" {
  description = "List of CIDR blocks for the private subnets"
  type        = list(string)
}

variable "public_subnets_cidr" {
  description = "List of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "project_name" {
  description = "Project name for tagging resources"
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
}

variable "instance_type" {
  description = "Instance type for the EC2 instances"
  default     = "t2.micro"
}

variable "asg_max_size" {
  description = "Maximum number of instances in the autoscaling group"
}

variable "asg_min_size" {
  description = "Minimum number of instances in the autoscaling group"
}

variable "asg_desired_capacity" {
  description = "Desired number of instances in the autoscaling group"
}