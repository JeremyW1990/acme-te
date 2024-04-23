variable "ami_id" {
  description = "The AMI ID for the EC2 instances."
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start."
  type        = string
}

variable "key_name" {
  description = "The key name of the Key Pair to use for the instance."
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the EC2 instances will reside."
  type        = string
}

variable "security_groups" {
  description = "A list of security group IDs to associate with."
  type        = list(string)
}

variable "subnet_ids" {
  description = "A list of subnet IDs to launch resources in."
  type        = list(string)
}

variable "desired_capacity" {
  description = "The number of Amazon EC2 instances that should be running in the group."
  type        = number
}

variable "min_size" {
  description = "The minimum size of the group."
  type        = number
}

variable "max_size" {
  description = "The maximum size of the group."
  type        = number
}

variable "user_data" {
  description = "The user data to provide when launching the instances."
  type        = string
  default     = ""
}

variable "tags" {
  description = "A map of tags to add to all resources."
  type        = map(string)
  default     = {}
}