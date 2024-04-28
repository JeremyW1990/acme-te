variable "vpc_cidr" {
  type        = string
  description = "The CIDR block for the VPC."
}

variable "public_subnets_cidrs" {
  type        = list(string)
  description = "The list of CIDR blocks for the public subnets."
}