### Terraform Module for SNS with Email Subscription

#### Directory Structure

```
terraform-sns-module/
  ├── sns/
  │   ├── main.tf
  │   ├── variables.tf
  │   ├── outputs.tf
  │   └── README.md
```

#### `sns/main.tf`

```hcl
resource "aws_sns_topic" "topic" {
  name = var.topic_name
  tags = {
    Name = var.topic_name
    Environment = var.environment
  }
}

resource "aws_sns_topic_subscription" "email" {
  topic_arn = aws_sns_topic.topic.arn
  protocol  = "email"
  endpoint  = var.email_address
}
```

#### `sns/variables.tf`

```hcl
variable "topic_name" {
  description = "The name of the SNS topic"
  type        = string
}

variable "email_address" {
  description = "The email address for the SNS subscription"
  type        = string
}

variable "environment" {
  description = "The environment for the SNS topic"
  type        = string
}
```

#### `sns/outputs.tf`

```hcl
output "topic_arn" {
  description = "The ARN of the SNS topic"
  value       = aws_sns_topic.topic.arn
}
```

#### `sns/README.md`

```markdown
# SNS Module

This module creates an SNS topic with an email subscription.

## Resources

| Name                              | Type                        |
|-----------------------------------|-----------------------------|
| `aws_sns_topic.topic`             | SNS Topic                   |
| `aws_sns_topic_subscription.email` | SNS Topic Email Subscription|

## Inputs

| Name           | Description                            | Type   | Default | Required |
|----------------|----------------------------------------|--------|---------|----------|
| `topic_name`   | The name of the SNS topic              | string | n/a     | yes      |
| `email_address`| The email address for the SNS subscription | string | n/a     | yes      |
| `environment`  | The environment for the SNS topic      | string | n/a     | yes      |

## Outputs

| Name       | Description             |
|------------|-------------------------|
| `topic_arn`| The ARN of the SNS topic|
```

### Example Usage

Here's how to call the module:

#### `main.tf`

```hcl
provider "aws" {
  region = "us-west-2"
}

module "sns_topic" {
  source        = "./sns"
  topic_name    = "example-sns-topic"
  email_address = "example@example.com"
  environment   = "dev"
}
```
