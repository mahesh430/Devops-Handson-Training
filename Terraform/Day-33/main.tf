provider "aws" {
  region = var.aws_region
  profile = var.profile
}

resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Env = "Production"
    Owner = "Mahesh"
    Name = "ExampleInstance-${terraform.workspace}"
  }
}

