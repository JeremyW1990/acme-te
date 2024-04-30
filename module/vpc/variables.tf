variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "azs" {
  description = "The availability zones in the region"
  type        = list(string)
}

variable "private_subnets" {
  description = "The list of private subnet CIDR blocks"
  type        = list(string)
}

variable "public_subnets" {
  description = "The list of public subnet CIDR blocks"
  type        = list(string)
}

variable "tags" {
  description = "The tags to apply to resources"
  type        = map(string)
}