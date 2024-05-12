variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "public_subnets" {
  description = "The list of public subnet CIDR blocks"
  type        = list(string)
}

data "aws_availability_zones" "available" {}