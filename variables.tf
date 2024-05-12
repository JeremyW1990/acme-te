variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
  default     = "10.0.0.0/16"
}

variable "vpc_subnet_cidr_blocks" {
  description = "The list of CIDR blocks for the subnets in the VPC."
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "vpc_availability_zones" {
  description = "The list of availability zones in which to create subnets."
  type        = list(string)
  default     = ["us-east-1a", "us-east-1b"]
}

# EC2 module defaults are defined in module variables file
variable "ec2_ami_id" {}
variable "ec2_instance_type" {}
variable "ec2_asg_min_size" {}
variable "ec2_asg_max_size" {}
variable "ec2_asg_desired_capacity" {}
variable "ec2_alb_access_cidr" {}