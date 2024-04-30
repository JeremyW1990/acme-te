variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
}

variable "public_subnets" {
  description = "A list of public subnet CIDR blocks."
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones in the region"
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instances."
  type        = string
}

variable "asg_min_size" {
  description = "The minimum size of the Auto Scaling Group."
  type        = number
}

variable "asg_max_size" {
  description = "The maximum size of the Auto Scaling Group."
  type        = number
}