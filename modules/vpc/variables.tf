variable "name_suffix" {
  description = "A suffix to append to resources names to ensure uniqueness"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets_cidr" {
  description = "A list of CIDR blocks for the public subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones in the region"
  type        = list(string)
}