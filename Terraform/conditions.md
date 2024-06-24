### Terraform Conditions Documentation

#### Overview

Terraform conditions allow you to create resources or modify configurations based on specific criteria. This is useful for creating dynamic and flexible infrastructure configurations.

#### Conditional Expressions

Conditional expressions in Terraform use the ternary operator syntax:

```hcl
condition ? true_value : false_value
```

- **condition**: The expression to evaluate.
- **true_value**: The value if the condition is true.
- **false_value**: The value if the condition is false.

#### Examples

##### Conditional Resource Creation

You can use conditional expressions to decide whether to create a resource or not. However, it's important to note that Terraform does not support conditional creation directly. Instead, you can use the `count` or `for_each` meta-arguments to achieve this.

**Example 1: Using `count`**

```hcl
variable "create_instance" {
  description = "Flag to create the instance"
  type        = bool
  default     = true
}

resource "aws_instance" "example" {
  count         = var.create_instance ? 1 : 0
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "ConditionalInstance"
  }
}
```

In this example, the instance will only be created if `var.create_instance` is `true`.

##### Conditional Logic in Variables

You can define variables with default values based on conditions.

```hcl
variable "environment" {
  description = "The environment to deploy to"
  type        = string
  default     = "dev"
}

variable "instance_type" {
  description = "Instance type based on environment"
  type        = string
  default     = var.environment == "prod" ? "t2.large" : "t2.micro"
}
```

In this example, the `instance_type` variable will have different default values based on the `environment` variable.
