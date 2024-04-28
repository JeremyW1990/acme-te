variable "ami_id" {
  description = "The AMI ID for the EC2 instances."
}

variable "instance_type" {
  description = "The instance type for the EC2 instances."
  default     = "t2.micro" # You can change this default as needed
}

variable "subnets" {
  type        = list(string)
  description = "A list of subnet IDs to launch resources in"
}

variable "vpc_id" {
  description = "The VPC ID where the resources will be created."
}

variable "asg_max_size" {
  description = "The maximum size of the autoscaling group."
}

variable "asg_min_size" {
  description = "The minimum size of the autoscaling group."
}

variable "asg_desired_capacity" {
  description = "The desired capacity of the autoscaling group."
}