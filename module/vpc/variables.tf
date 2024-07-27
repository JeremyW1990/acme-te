variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"  # Added default value
}

variable "instance_tenancy" {
  description = "Instance tenancy option for the VPC"
  type        = string
  default     = "default"
}

variable "enable_dns_hostnames" {
  description = "Enable DNS hostnames in the VPC"
  type        = bool
  default     = true
}

variable "enable_dns_support" {
  description = "Enable DNS support in the VPC"
  type        = bool
  default     = false
}

variable "name" {
  description = "The name of the VPC for tagging purposes"
  type        = string
}

variable "public_subnets" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
}

variable "private_subnets" {
  description = "List of private subnet CIDR blocks"
  type        = list(string)
}

variable "availability_zones" {
  description = "List of availability zones in the region"
  type        = list(string)
}

variable "map_public_ip_on_launch" {
  description = "Enable auto-assign public IP on launch for public subnets"
  type        = bool
  default     = true
}