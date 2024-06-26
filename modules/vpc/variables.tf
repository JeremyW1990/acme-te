variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnet CIDR blocks."
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones in the region."
  type        = list(string)
}

variable "vpc_name" {
  description = "The name of the VPC."
  type        = string
}
