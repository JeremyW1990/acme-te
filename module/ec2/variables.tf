variable "ami_id" {
  description = "The ID of the AMI to use with the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The instance type to use with the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "enable_monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = true
}

variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnets" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
}

variable "asg_min_size" {
  description = "The minimum size of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "The maximum size of the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "asg_desired_capacity" {
  description = "The desired capacity of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "name" {
  description = "The name prefix for the resources"
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnet IDs for the load balancer"
  type        = list(string)
}