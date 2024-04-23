variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "public_subnets" {
  description = "A list of public subnets inside the VPC."
  type        = list(string)
}

variable "private_subnets" {
  description = "A list of private subnets inside the VPC."
  type        = list(string)
}

variable "availability_zones" {
  description = "A list of availability zones in the region"
  type        = list(string)
}

variable "enable_dns_hostnames" {
  description = "Should be true to enable DNS hostnames in the VPC."
  default     = true
}

variable "enable_dns_support" {
  description = "Should be true to enable DNS support in the VPC."
  default     = true
}