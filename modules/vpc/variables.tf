variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnet CIDR blocks."
  type        = list(string)
}

variable "azs" {
  description = "A list of availability zones in the region."
  type        = list(string)
}