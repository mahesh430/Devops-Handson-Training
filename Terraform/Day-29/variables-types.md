# Terraform Variables and Types

## Overview

Terraform uses variables to provide flexibility and reusability in your configuration. Variables can have different types, which define the kind of data they can hold. Understanding variable types helps you write more robust and clear Terraform code.

## Variable Types

Terraform supports several types of variables:

1. **string**
2. **number**
3. **bool**
4. **list(type)**
5. **map(type)**
6. **set(type)**
7. **object({attribute_name=type, ...})**
8. **tuple([type, ...])**

## Defining Variables

You define variables in a `variables.tf` file or within any `.tf` file using the `variable` block. Here are examples of each type:

### String

A `string` variable holds text data.

```hcl
variable "example_string" {
  type    = string
  default = "Hello, Terraform!"
}
```

### Number

A `number` variable holds numeric data, either integer or float.

```hcl
variable "example_number" {
  type    = number
  default = 42
}
```

### Boolean

A `bool` variable holds a boolean value: `true` or `false`.

```hcl
variable "example_bool" {
  type    = bool
  default = true
}
```

### List

A `list` variable holds an ordered collection of values of a specified type.

```hcl
variable "example_list" {
  type    = list(string)
  default = ["one", "two", "three"]
}
```

### Map

A `map` variable holds key-value pairs where the keys are strings and the values are of a specified type.

```hcl
variable "example_map" {
  type    = map(string)
  default = {
    key1 = "value1"
    key2 = "value2"
  }
}
```

### Set

A `set` variable holds an unordered collection of unique values of a specified type.

```hcl
variable "example_set" {
  type    = set(string)
  default = ["value1", "value2", "value3"]
}
```

### Object

An `object` variable holds a collection of named attributes that each have their own specified type.

```hcl
variable "example_object" {
  type = object({
    attribute1 = string
    attribute2 = number
    attribute3 = bool
  })
  default = {
    attribute1 = "example"
    attribute2 = 10
    attribute3 = true
  }
}
```

### Tuple

A `tuple` variable holds an ordered collection of values of different specified types.

```hcl
variable "example_tuple" {
  type = tuple([string, number, bool])
  default = ["example", 10, true]
}
```

## Using Variables

You can use variables in your Terraform configuration by referencing them with `var.<variable_name>`.

Example:

```hcl
resource "aws_instance" "example" {
  ami           = var.example_ami
  instance_type = var.example_instance_type
}
```

## Real World Scenario

### Scenario: Configuring an AWS Instance

In this scenario, we define variables to configure an AWS EC2 instance. We will use different types to demonstrate their usage.

#### Define Variables

```hcl
variable "instance_name" {
  type    = string
  default = "example-instance"
}

variable "instance_type" {
  type    = string
  default = "t2.micro"
}

variable "tags" {
  type = map(string)
  default = {
    Name        = "example-instance"
    Environment = "dev"
  }
}

variable "security_groups" {
  type = list(string)
  default = ["sg-12345678", "sg-87654321"]
}
```

#### Use Variables in Configuration

```hcl
resource "aws_instance" "example" {
  ami           = "ami-0abcdef1234567890"
  instance_type = var.instance_type
  tags          = var.tags
  security_groups = var.security_groups

  tags = {
    Name = var.instance_name
  }
}
```

## Best Practices

- **Default Values**: Provide default values for variables whenever possible to make your configuration reusable and easier to understand.
- **Type Constraints**: Use type constraints to ensure the values provided are of the expected type, helping to prevent errors.
- **Documentation**: Document your variables clearly, explaining what each variable represents and its expected values.
