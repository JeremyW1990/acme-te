variable "vpc_id" {
  description = "The ID of the VPC to deploy resources into"
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs to deploy resources into"
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID to use for the EC2 instances"
  type        = string
  default     = "ami-0b0ea68c435eb488d"
}

variable "instance_type" {
  description = "EC2 instance type"
  type        = string
  default     = "t2.micro"
}

variable "asg_min_size" {
  description = "Minimum size of the autoscaling group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum size of the autoscaling group"
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "Desired capacity of the autoscaling group"
  type        = number
  default     = 2
}
