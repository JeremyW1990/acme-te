variable "ami_id" {
  description = "The ID of the AMI to use with the EC2 instances"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "The VPC ID where resources will be created"
  type        = string
}

variable "vpc_zone_identifier" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
}

variable "min_size" {
  description = "The minimum size of the autoscale group"
  type        = number
  default     = 1
}

variable "max_size" {
  description = "The maximum size of the autoscale group"
  type        = number
  default     = 3
}

variable "desired_capacity" {
  description = "The desired capacity of the autoscale group"
  type        = number
  default     = 1
}

variable "health_check_type" {
  description = "Controls how health checking is done"
  type        = string
  default     = "EC2"
}

variable "user_data" {
  description = "The user data to provide when launching the instances"
  type        = string
  default     = ""
}

variable "alb_subnets" {
  description = "A list of subnet IDs to attach to the ALB"
  type        = list(string)
}

variable "alb_subnet_cidrs" {
  description = "A list of CIDRs of the subnets attached to the ALB, for security group rule"
  type        = list(string)
}

variable "target_group_port" {
  description = "The port on which targets receive traffic"
  type        = number
  default     = 80
}

variable "listener_port" {
  description = "The port on which the listener listens for traffic"
  type        = number
  default     = 80
}
