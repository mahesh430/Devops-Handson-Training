# variables.tf
variable "ami_ids" {
  description = "Map of AMI IDs for different regions"
  type        = map(string)
  default     = {
    us-east-1      = "ami-0c55b159cbfafe1f0"
    us-west-1      = "ami-0abcdef1234567890"
    eu-west-1      = "ami-0abcdef1234567890"
    ap-southeast-1 = "ami-0abcdef1234567890"
  }
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
