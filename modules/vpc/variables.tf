variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "List of CIDR blocks for the Subnets"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones in which to create the subnets"
  type        = list(string)
}