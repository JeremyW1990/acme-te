variable "vpc_cidr" {
  description = "The CIDR block for the VPC."
  type        = string
}

variable "vpc_name" {
  description = "The name tag of the VPC and related resources."
  type        = string
}

variable "subnets_cidr" {
  description = "List of CIDR blocks for the subnets within the VPC."
  type        = list(string)
}

variable "availability_zones" {
  description = "List of AZs in which to distribute the subnets."
  type        = list(string)
}

variable "map_public_ip_on_launch" {
  description = "Should the subnet allocate public IPs on launch."
  type        = bool
  default     = false
}

variable "public_subnets_cidr" {
  description = "List of CIDR blocks for the public subnets."
  type        = list(string)
}

# Add more variables for additional customization if required, such as for private subnets, NAT gateways, etc.