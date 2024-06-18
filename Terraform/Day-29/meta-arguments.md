Here's a detailed example of how to use Terraform meta-arguments, including `count`, `depends_on`, `for_each`, and `lifecycle`, formatted in a GitHub-friendly documentation style.

```markdown
# Terraform Meta-Arguments Examples

This document provides examples of using Terraform meta-arguments: `count`, `depends_on`, `for_each`, and `lifecycle`.
```
## Count

The `count` meta-argument allows you to specify how many instances of the resource you want to create.

### Example 1

```bash
resource "aws_instance" "example" {
  count         = 2
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance-${count.index}"
  }
}
```

In this example, two EC2 instances are created with the tags `Name = example-instance-0` and `Name = example-instance-1`.
 ### Example 2
 ```bash
# variables.tf
variable "ami" {
  type    = string
  default = "ami-0078ef784b6fa1ba4"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "sandboxes" {
  type    = list(string)
  default = ["sandbox_one", "sandbox_two", "sandbox_three"]
}

# main.tf
resource "aws_instance" "sandbox" {
  ami           = var.ami
  instance_type = var.instance_type
  count         = length(var.sandboxes) 
  tags = {
    Name = var.sandboxes[count.index]
  }
}
```
## Depends_on

The `depends_on` meta-argument explicitly specifies dependencies between resources.

### Example

```hcl
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.example.id

  depends_on = [aws_vpc.example]
}
```

In this example, the subnet depends on the VPC, ensuring the VPC is created before the subnet.

## For_each

The `for_each` meta-argument allows you to iterate over a map or set to create multiple instances of a resource.

### Example 

```bash
# variables.tf
variable "ami" {
  type    = string
  default = "ami-0078ef784b6fa1ba4"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "sandboxes" {
  type    = list(string)
  default = ["sandbox_one", "sandbox_two", "sandbox_three"]
}

# main.tf
resource "aws_instance" "sandbox" {
  ami           = var.ami
  instance_type = var.instance_type
  for_each      = toset(var.sandboxes)
  tags = {
    Name = each.value # for a set, each.value and each.key is the same
  }
}

```
## Lifecycle

The `lifecycle` meta-argument allows you to customize the behavior of Terraform for creating and destroying resources.

### Example

```hcl
resource "aws_s3_bucket" "example" {
  bucket = "example-bucket"

  lifecycle {
    prevent_destroy = true
  }
}
```
## Full Example

Combining all the meta-arguments in a single example:

### `variables.tf`

```hcl
variable "ami" {
  type    = string
  default = "ami-0078ef784b6fa1ba4"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "sandboxes" {
  type    = list(string)
  default = ["sandbox_one", "sandbox_two", "sandbox_three"]
}
```

### `main.tf`

```hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"
}

resource "aws_subnet" "example" {
  cidr_block = "10.0.1.0/24"
  vpc_id     = aws_vpc.example.id

  depends_on = [aws_vpc.example]

  tags = {
    Name = "example-subnet"
  }
}

resource "aws_instance" "sandbox" {
  ami           = var.ami
  instance_type = var.instance_type
  for_each      = toset(var.sandboxes)
  tags = {
    Name = each.value
  }

  lifecycle {
    create_before_destroy = true
    prevent_destroy       = false
    ignore_changes        = [ami]
    replace_triggered_by  = [aws_vpc.example.id]
  }
}
```

### `outputs.tf`

Optionally, add outputs to display instance information:

```hcl
output "instance_ids" {
  value = [for inst in aws_instance.sandbox : inst.id]
}

output "instance_public_ips" {
  value = [for inst in aws_instance.sandbox : inst.public_ip]
}
```

In this full example:
- The `ami` and `instance_type` variables are used for the AMI ID and instance type.
- The `sandboxes` variable is a list of strings representing sandbox environments.
- The `for_each` meta-argument iterates over the `sandboxes` set to create an EC2 instance for each sandbox.
- The `depends_on` meta-argument ensures the subnet is created after the VPC.
- The `lifecycle` block demonstrates all available lifecycle meta-arguments, including `create_before_destroy`, `prevent_destroy`, `ignore_changes`, and `replace_triggered_by`.
- Outputs are added to display the IDs and public IPs of the created instances.

Feel free to use and adapt these examples for your Terraform projects.
```
