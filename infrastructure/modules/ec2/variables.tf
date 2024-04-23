variable "vpc_id" {
  description = "The VPC ID where resources will be created"
  type        = string
}

variable "subnets" {
  description = "The subnets for the Autoscaling group and ALB"
  type        = list(string)
}

variable "image_id" {
  description = "The AMI to use for the instance"
  type        = string
}

variable "instance_type" {
  description = "The type of instance to start"
  type        = string
}

variable "app_port" {
  description = "The port on which the application will run"
  type        = number
}

variable "asg_min_size" {
  description = "The minimum size of the autoscaling group"
  type        = number
}

variable "asg_max_size" {
  description = "The maximum size of the autoscaling group"
  type        = number
}

variable "asg_desired_capacity" {
  description = "The desired capacity of the autoscaling group"
  type        = number
}

variable "health_check_path" {
  description = "The health check path for the load balancer"
  type        = string
  default     = "/"
}