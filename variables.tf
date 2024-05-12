variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "public_subnets" {
  description = "The list of public subnet CIDR blocks"
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  default     = "ami-0b0ea68c435eb488d"
}

variable "instance_type" {
  description = "The type of instance to start"
  default     = "t2.micro"
}

variable "asg_min_size" {
  description = "The minimum size of the autoscaling group"
  default     = 1
}

variable "asg_max_size" {
  description = "The maximum size of the autoscaling group"
  default     = 3
}

variable "asg_desired_capacity" {
  description = "The desired capacity of the autoscaling group"
  default     = 1
}