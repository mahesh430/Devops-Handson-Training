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
