variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}

variable "vpc_cidr" {
  type        = string
  description = "CIDR block for the VPC"
}

variable "azs" {
  type        = list(string)
  description = "Availability Zones"
}

variable "private_subnets" {
  type        = list(string)
  description = "CIDR blocks for the private subnets"
}

variable "public_subnets" {
  type        = list(string)
  description = "CIDR blocks for the public subnets"
}

variable "project_name" {
  type        = string
  description = "Project name for tagging resources"
}