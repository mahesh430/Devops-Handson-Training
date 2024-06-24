# variables.tf
variable "ami_ids" {
  description = "Map of AMI IDs for different regions"
  type        = map(string)
  default     = {
    us-east-1      = "ami-08a0d1e16fc3f61ea"
    us-west-1      = "ami-033fabdd332044f06"
    eu-west-1      = "ami-0551ce4d67096d606"
    ap-south-1     = "ami-0e1d06225679bc1c5"
  }
}

variable "aws_region" {
  description = "The AWS region to deploy the instance"
  type        = string
  default     = "us-east-1"
}

variable "security_group_rules" {
  description = "Map of security group rules"
  type        = map(map(string))
  default = {
    ssh = {
      from_port = "22"
      to_port   = "22"
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    }
    http = {
      from_port = "80"
      to_port   = "80"
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    }
    https = {
      from_port = "443"
      to_port   = "443"
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    }
  }
}
