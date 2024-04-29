variable "vpc_id" {
  description = "The VPC ID where resources will be created."
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs for locating resources."
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "The instance type for the EC2 instances."
  type        = string
  default     = "t2.micro"
}

variable "application_port" {
  description = "The port the application will use."
  type        = number
  default     = 80
}

variable "asg_min_size" {
  description = "The minimum size of the ASG."
  type        = number
}

variable "asg_max_size" {
  description = "The maximum size of the ASG."
  type        = number
}

variable "asg_desired_capacity" {
  description = "The desired capacity of the ASG."
  type        = number
}