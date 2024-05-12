variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  default     = "10.0.0.0/16"
}

variable "availability_zones" {
  description = "List of availability zones in which to create subnets"
  default     = ["us-east-1a", "us-east-1b", "us-east-1c"]
}

variable "ami_id" {
  description = "The AMI ID for the EC2 instances"
  default     = "ami-0b0ea68c435eb488d"
}

variable "instance_type" {
  description = "The instance type of the EC2 instance"
  default     = "t2.micro"
}

variable "asg_min_size" {
  description = "The minimum size of the autoscale group"
  default     = 1
}

variable "asg_max_size" {
  description = "The maximum size of the autoscale group"
  default     = 3
}

variable "asg_desired_capacity" {
  description = "The desired number of instances in the autoscale group"
  default     = 1
}

variable "server_port" {
  description = "The port on which the server will run"
  default     = 8080
}