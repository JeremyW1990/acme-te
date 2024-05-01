variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
}

variable "public_subnets" {
  description = "A list of public subnet CIDR blocks."
}

variable "azs" {
  description = "A list of availability zones in the region."
}

variable "application_name" {
  description = "The name of the application."
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances."
}

variable "instance_type" {
  description = "The instance type of the EC2 instances."
}

variable "asg_min_size" {
  description = "The minimum size of the autoscaling group."
}

variable "asg_max_size" {
  description = "The maximum size of the autoscaling group."
}

variable "asg_desired_capacity" {
  description = "The desired capacity of the autoscaling group."
}