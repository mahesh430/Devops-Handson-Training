variable "ami_id" {
  description = "The AMI ID for the instance"
  type        = string
}

variable "instance_type" {
  description = "The instance type"
  type        = string
}

variable "key_name" {
  description = "The key name to use for the instance"
  type        = string
}

variable "security_group_name" {
  description = "The name prefix for the security group"
  type        = string
}

variable "vpc_id" {
  description = "The VPC ID where the instance will be launched"
  type        = string
}

variable "instance_name" {
  description = "The name of the instance"
  type        = string
}
