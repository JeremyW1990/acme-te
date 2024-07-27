variable "aws_region" {
  description = "The AWS region to deploy resources into"
  default     = "us-east-1"
}

variable "vpc_cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_instance_tenancy" {
  description = "The instance tenancy option for the VPC"
  type        = string
  default     = "default"
}

variable "vpc_enable_dns_hostnames" {
  description = "Whether to enable DNS hostnames in this VPC"
  type        = bool
  default     = true
}

variable "vpc_enable_dns_support" {
  description = "Whether to enable DNS support in this VPC"
  type        = bool
  default     = true
}

variable "vpc_name" {
  description = "The name prefix for the VPC"
  type        = string
}

variable "vpc_public_subnets" {
  description = "A list of public subnet CIDR blocks"
  type        = list(string)
}

variable "vpc_private_subnets" {
  description = "A list of private subnet CIDR blocks"
  type        = list(string)
}

variable "vpc_availability_zones" {
  description = "A list of availability zones"
  type        = list(string)
}

variable "vpc_map_public_ip_on_launch" {
  description = "Whether to map public IPs on launch in public subnets"
  type        = bool
  default     = true
}

variable "ec2_ami_id" {
  description = "The ID of the AMI to use with the EC2 instances"
  default     = "ami-0b0ea68c435eb488d"
}

variable "ec2_instance_type" {
  description = "The instance type to use with the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "ec2_enable_monitoring" {
  description = "If true, the launched EC2 instance will have detailed monitoring enabled"
  type        = bool
  default     = true
}

variable "ec2_asg_min_size" {
  description = "The minimum size of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "ec2_asg_max_size" {
  description = "The maximum size of the Auto Scaling Group"
  type        = number
  default     = 3
}

variable "ec2_asg_desired_capacity" {
  description = "The desired capacity of the Auto Scaling Group"
  type        = number
  default     = 1
}

variable "ec2_name" {
  description = "The name prefix for the EC2 resources"
  type        = string
}