variable "aws_region" {
  description = "AWS region to deploy the infrastructure"
  type        = string
  default     = "us-west-2"
}

variable "application_name" {
  description = "Name of the application for tagging"
  type        = string
  default     = "cloud_ai_app"
}

variable "vpc_cidr" {
  description = "CIDR block for the VPC"
  type        = string
  default     = "10.0.0.0/16"
}

variable "public_subnet_cidrs" {
  description = "List of public subnet CIDR blocks"
  type        = list(string)
  default     = ["10.0.1.0/24", "10.0.2.0/24"]
}

variable "availability_zones" {
  description = "List of availability zones in the region"
  type        = list(string)
  default     = ["us-west-2a", "us-west-2b"]
}