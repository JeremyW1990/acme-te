variable "vpc_id" {
  description = "The ID of the VPC"
  type        = string
}

variable "subnets" {
  description = "List of subnet IDs to associate with the autoscaling group"
  type        = list(string)
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  default     = "ami-0b0ea68c435eb488d"
}

variable "instance_type" {
  description = "The instance type of the EC2 instance"
  default     = "t2.micro"
}

variable "min_size" {
  description = "The minimum size of the autoscale group"
  default     = 1
}

variable "max_size" {
  description = "The maximum size of the autoscale group"
  default     = 3
}

variable "desired_capacity" {
  description = "The desired number of instances in the autoscale group"
  default     = 1
}

variable "server_port" {
  description = "The port on which the server will run"
  default     = "8080"
}