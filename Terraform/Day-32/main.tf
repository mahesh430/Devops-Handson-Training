# main.tf
provider "aws" {
  region = "us-east-1" # Specify the desired region
}

# Security group creation using dynamic blocks
resource "aws_security_group" "dynamic_sg" {
  name        = "dynamic-sg"
  description = "Dynamic Security Group"
  vpc_id      = "vpc-123456"  # Replace with your VPC ID

  dynamic "ingress" {
    for_each = var.security_group_rules
    content {
      from_port   = ingress.value.from_port
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.cidr]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

# Single instance creation using the map variable
resource "aws_instance" "example" {
  ami           = var.ami_ids[var.aws_region]
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.dynamic_sg.id]

  tags = {
    Name = "ExampleInstance"
  }
}
