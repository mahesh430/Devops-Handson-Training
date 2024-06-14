### Terraform Module for VPC

#### Directory Structure

```
terraform-vpc-module/
  ├── vpc/
  │   ├── main.tf
  │   ├── variables.tf
  │   ├── outputs.tf
  │   └── README.md
```

#### `vpc/main.tf`

```hcl
resource "aws_vpc" "main" {
  cidr_block = var.vpc_cidr
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = var.vpc_name
  }
}

resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-igw"
  }
}

resource "aws_subnet" "public" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.public_subnet_cidr
  map_public_ip_on_launch = true
  availability_zone = var.public_subnet_az
  tags = {
    Name = "${var.vpc_name}-public"
  }
}

resource "aws_subnet" "private" {
  vpc_id     = aws_vpc.main.id
  cidr_block = var.private_subnet_cidr
  availability_zone = var.private_subnet_az
  tags = {
    Name = "${var.vpc_name}-private"
  }
}

resource "aws_route_table" "public" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-public-rt"
  }
}

resource "aws_route" "public_route" {
  route_table_id         = aws_route_table.public.id
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = aws_internet_gateway.igw.id
}

resource "aws_route_table_association" "public" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.public.id
}

resource "aws_route_table" "private" {
  vpc_id = aws_vpc.main.id
  tags = {
    Name = "${var.vpc_name}-private-rt"
  }
}

resource "aws_route_table_association" "private" {
  subnet_id      = aws_subnet.private.id
  route_table_id = aws_route_table.private.id
}
```

#### `vpc/variables.tf`

```hcl
variable "vpc_cidr" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}

variable "public_subnet_cidr" {
  description = "The CIDR block for the public subnet"
  type        = string
}

variable "private_subnet_cidr" {
  description = "The CIDR block for the private subnet"
  type        = string
}

variable "public_subnet_az" {
  description = "The availability zone for the public subnet"
  type        = string
}

variable "private_subnet_az" {
  description = "The availability zone for the private subnet"
  type        = string
}
```

#### `vpc/outputs.tf`

```hcl
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}

output "public_subnet_id" {
  description = "The ID of the public subnet"
  value       = aws_subnet.public.id
}

output "private_subnet_id" {
  description = "The ID of the private subnet"
  value       = aws_subnet.private.id
}

output "public_route_table_id" {
  description = "The ID of the public route table"
  value       = aws_route_table.public.id
}

output "private_route_table_id" {
  description = "The ID of the private route table"
  value       = aws_route_table.private.id
}

output "internet_gateway_id" {
  description = "The ID of the internet gateway"
  value       = aws_internet_gateway.igw.id
}
```

#### `vpc/README.md`

```markdown
# VPC Module

This module creates a VPC with one public subnet, one private subnet, route tables, an internet gateway, and subnet associations.

## Resources

| Name                           | Type                    |
|--------------------------------|-------------------------|
| `aws_vpc`                      | VPC                     |
| `aws_internet_gateway`         | Internet Gateway        |
| `aws_subnet.public`            | Public Subnet           |
| `aws_subnet.private`           | Private Subnet          |
| `aws_route_table.public`       | Public Route Table      |
| `aws_route_table.private`      | Private Route Table     |
| `aws_route.public_route`       | Public Route            |
| `aws_route_table_association.public` | Public Route Table Association |
| `aws_route_table_association.private` | Private Route Table Association |

## Inputs

| Name               | Description                             | Type   | Default | Required |
|--------------------|-----------------------------------------|--------|---------|----------|
| `vpc_cidr`         | The CIDR block for the VPC              | string | n/a     | yes      |
| `vpc_name`         | The name of the VPC                     | string | n/a     | yes      |
| `public_subnet_cidr` | The CIDR block for the public subnet | string | n/a     | yes      |
| `private_subnet_cidr` | The CIDR block for the private subnet | string | n/a     | yes      |
| `public_subnet_az` | The availability zone for the public subnet | string | n/a     | yes      |
| `private_subnet_az` | The availability zone for the private subnet | string | n/a     | yes      |

## Outputs

| Name                   | Description                       |
|------------------------|-----------------------------------|
| `vpc_id`               | The ID of the VPC                 |
| `public_subnet_id`     | The ID of the public subnet       |
| `private_subnet_id`    | The ID of the private subnet      |
| `public_route_table_id` | The ID of the public route table |
| `private_route_table_id` | The ID of the private route table |
| `internet_gateway_id`  | The ID of the internet gateway    |
```

### Example Usage

Here's how to call the module:

#### `main.tf`

```hcl
provider "aws" {
  region = "us-west-2"
}

module "vpc" {
  source              = "./vpc"
  vpc_cidr            = "10.0.0.0/16"
  vpc_name            = "example-vpc"
  public_subnet_cidr  = "10.0.1.0/24"
  private_subnet_cidr = "10.0.2.0/24"
  public_subnet_az    = "us-west-2a"
  private_subnet_az   = "us-west-2b"
}
```

