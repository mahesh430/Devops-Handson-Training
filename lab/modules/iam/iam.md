### Terraform Module for IAM Policies and Roles for S3 Read-Only Access

#### Directory Structure

```
terraform-iam-module/
  ├── iam/
  │   ├── main.tf
  │   ├── variables.tf
  │   ├── outputs.tf
  │   └── README.md
```

#### `iam/main.tf`

```hcl
resource "aws_iam_role" "ec2_role" {
  name = var.role_name

  assume_role_policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = "sts:AssumeRole",
        Effect = "Allow",
        Principal = {
          Service = "ec2.amazonaws.com",
        },
      },
    ],
  })

  tags = {
    Name = var.role_name
    Environment = var.environment
  }
}

resource "aws_iam_policy" "s3_read_only" {
  name        = var.policy_name
  description = "Read-only access to S3"
  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Action = [
          "s3:GetObject",
          "s3:ListBucket",
        ],
        Effect   = "Allow",
        Resource = [
          "arn:aws:s3:::${var.bucket_name}",
          "arn:aws:s3:::${var.bucket_name}/*",
        ],
      },
    ],
  })

  tags = {
    Name = var.policy_name
    Environment = var.environment
  }
}

resource "aws_iam_role_policy_attachment" "attach_policy" {
  role       = aws_iam_role.ec2_role.name
  policy_arn = aws_iam_policy.s3_read_only.arn
}
```

#### `iam/variables.tf`

```hcl
variable "role_name" {
  description = "The name of the IAM role"
  type        = string
}

variable "policy_name" {
  description = "The name of the IAM policy"
  type        = string
}

variable "bucket_name" {
  description = "The name of the S3 bucket"
  type        = string
}

variable "environment" {
  description = "The environment for the IAM resources"
  type        = string
}
```

#### `iam/outputs.tf`

```hcl
output "role_arn" {
  description = "The ARN of the IAM role"
  value       = aws_iam_role.ec2_role.arn
}

output "policy_arn" {
  description = "The ARN of the IAM policy"
  value       = aws_iam_policy.s3_read_only.arn
}
```

#### `iam/README.md`

```markdown
# IAM Module

This module creates an IAM role with a policy that provides read-only access to an S3 bucket.

## Resources

| Name                                      | Type                                 |
|-------------------------------------------|--------------------------------------|
| `aws_iam_role.ec2_role`                   | IAM Role                             |
| `aws_iam_policy.s3_read_only`             | IAM Policy                           |
| `aws_iam_role_policy_attachment.attach_policy` | IAM Role Policy Attachment          |

## Inputs

| Name          | Description                            | Type   | Default | Required |
|---------------|----------------------------------------|--------|---------|----------|
| `role_name`   | The name of the IAM role               | string | n/a     | yes      |
| `policy_name` | The name of the IAM policy             | string | n/a     | yes      |
| `bucket_name` | The name of the S3 bucket              | string | n/a     | yes      |
| `environment` | The environment for the IAM resources  | string | n/a     | yes      |

## Outputs

| Name         | Description             |
|--------------|-------------------------|
| `role_arn`   | The ARN of the IAM role |
| `policy_arn` | The ARN of the IAM policy|
```

### Example Usage

Here's how to call the module:

#### `main.tf`

```hcl
provider "aws" {
  region = "us-west-2"
}

module "iam_role" {
  source      = "./iam"
  role_name   = "example-ec2-role"
  policy_name = "example-s3-read-only-policy"
  bucket_name = "example-bucket"
  environment = "dev"
}
```
