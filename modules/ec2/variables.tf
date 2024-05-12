variable "vpc_id" {
  description = "The ID of the VPC where the resources will be deployed"
  type        = string
}

variable "subnet_ids" {
  description = "List of subnet IDs to place the Autoscaling Group instances in"
  type        = list(string)
}

variable "ami_id" {
  description = "The ID of the AMI to use for the EC2 instances"
  type        = string
  default     = "ami-0b0ea68c435eb488d"
}

variable "instance_type" {
  description = "The instance type of the EC2 instances"
  type        = string
  default     = "t3.micro"
}

variable "asg_min_size" {
  description = "The minimum size of the Autoscaling Group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "The maximum size of the Autoscaling Group"
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "The desired capacity of the Autoscaling Group"
  type        = number
  default     = 1
}

variable "alb_access_cidr" {
  description = "The CIDR block to allow access to the ALB"
  type        = string
  default     = "0.0.0.0/0"
}