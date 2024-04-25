variable "cidr_block" {
  description = "CIDR block for the VPC."
  type        = string
}

variable "public_subnets_cidr" {
  description = "List of CIDR blocks for the public subnets."
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones in the region."
  type        = list(string)
}