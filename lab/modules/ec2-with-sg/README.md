# EC2 Module

This module creates an EC2 instance and associated security group.

## Resources

| Name                   | Type             |
|------------------------|------------------|
| `aws_security_group`   | Security Group   |
| `aws_instance`         | EC2 Instance     |

## Inputs

| Name                  | Description                             | Type   | Default | Required |
|-----------------------|-----------------------------------------|--------|---------|----------|
| `ami_id`              | The AMI ID for the instance             | string | n/a     | yes      |
| `instance_type`       | The instance type                       | string | n/a     | yes      |
| `key_name`            | The key name to use for the instance    | string | n/a     | yes      |
| `security_group_name` | The name prefix for the security group  | string | n/a     | yes      |
| `vpc_id`              | The VPC ID where the instance will be launched | string | n/a     | yes      |
| `instance_name`       | The name of the instance                | string | n/a     | yes      |

## Outputs

| Name                | Description                       |
|---------------------|-----------------------------------|
| `instance_id`       | The ID of the EC2 instance        |
| `public_ip`         | The public IP of the EC2 instance |
| `security_group_id` | The ID of the security group      |
