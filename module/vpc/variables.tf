variable "vpc_cidr" {
  type        = string
  description = "CIDR for the VPC"
}

variable "public_subnets_cidr" {
  type        = list(string)
  description = "List of CIDR blocks for the public subnets"
}

variable "availability_zones" {
  type        = list(string)
  description = "List of availability zones in the region"
}

variable "vpc_name" {
  type        = string
  description = "Name of the VPC"
}