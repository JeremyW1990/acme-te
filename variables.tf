variable "vpc_cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnets_cidr" {
  description = "List of CIDR blocks for the public subnets."
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones in the region."
  type        = list(string)
}

variable "image_id" {
  description = "The EC2 image ID to be used."
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
  description = "The environment (e.g., dev, staging, prod)."
  type        = string
}