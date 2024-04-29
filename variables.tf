variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "A list of public subnet CIDR blocks."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "private_subnets" {
  description = "A list of private subnet CIDR blocks."
  type        = list(string)
  default     = ["10.0.3.0/24", "10.0.4.0/24"]
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
  description = "The minimum size of the autoscaling group."
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "The maximum size of the autoscaling group."
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "The desired capacity of the autoscaling group."
  type        = number
  default     = 2
}