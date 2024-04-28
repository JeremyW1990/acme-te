variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  type        = string
  default     = "ami-0b0ea68c435eb488d"
}

variable "instance_type" {
  description = "The instance type of the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "vpc_id" {
  description = "The VPC ID where the EC2 instances will be launched"
  type        = string
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch resources in"
  type        = list(string)
}

variable "asg_min_size" {
  description = "Minimum size of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "asg_max_size" {
  description = "Maximum size of the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "server_port" {
  description = "The server port for the EC2 instances"
  type        = number
  default     = 80
}