
### `main.tf`
```hcl
provider "aws" {
  region = "us-west-1"
  alias  = "us_west_1"
}

provider "aws" {
  region = "us-east-1"
  alias  = "us_east_1"
}

resource "aws_instance" "ec2_us_west_1" {
  provider = aws.us_west_1
  ami           = var.ami_us_west_1
  instance_type = var.instance_type

  tags = {
    Name        = "EC2 Instance US West 1"
    Environment = var.environment
  }
}

resource "aws_instance" "ec2_us_east_1" {
  provider = aws.us_east_1
  ami           = var.ami_us_east_1
  instance_type = var.instance_type

  tags = {
    Name        = "EC2 Instance US East 1"
    Environment = var.environment
  }
}
```

### `variables.tf`
```hcl
variable "ami_us_west_1" {
  description = "The AMI ID for the EC2 instance in us-west-1"
  type        = string
  default     = "ami-0c55b159cbfafe1f0"  # Replace with a valid AMI ID for us-west-1
}

variable "ami_us_east_1" {
  description = "The AMI ID for the EC2 instance in us-east-1"
  type        = string
  default     = "ami-0d5d9d301c853a04a"  # Replace with a valid AMI ID for us-east-1
}

variable "instance_type" {
  description = "The instance type for the EC2 instances"
  type        = string
  default     = "t2.micro"
}

variable "environment" {
  description = "The environment for the resources"
  type        = string
  default     = "production"
}
```

### `outputs.tf`
```hcl
output "ec2_instance_id_us_west_1" {
  value = aws_instance.ec2_us_west_1.id
}

output "ec2_instance_id_us_east_1" {
  value = aws_instance.ec2_us_east_1.id
}
```

### Explanation

1. **Providers**:
   - Two AWS providers are defined, each with a different alias (`us_west_1` and `us_east_1`), corresponding to different regions (`us-west-1` and `us-east-1`).

2. **Resources**:
   - Two EC2 instances are defined, each using one of the provider aliases to specify the region in which the instance should be created.

3. **Variables**:
   - Variables for AMI IDs, instance type, and environment tags are defined to make the configuration more flexible and reusable.

4. **Outputs**:
   - Outputs are defined to display the IDs of the created EC2 instances, providing a reference to the deployed resources.

By using provider aliases, this configuration allows you to deploy EC2 instances in different AWS regions within the same Terraform configuration. Adjust the AMI IDs and other variables as necessary for your specific use case.
