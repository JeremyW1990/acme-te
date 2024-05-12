variable "cidr_block" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "subnet_cidr_blocks" {
  description = "The list of subnets CIDR blocks."
  type        = list(string)
}

variable "availability_zones" {
  description = "The list of availability zones."
  type        = list(string)
}