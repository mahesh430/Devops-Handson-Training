
### Terraform Workspaces for Managing Environments

#### Overview

Terraform workspaces provide a mechanism to manage multiple environments (e.g., dev, test, prod) within a single Terraform configuration. Each workspace maintains its own state file, enabling isolated management of resources per environment.

#### Creating Workspaces

To create and switch between workspaces, use the following Terraform CLI commands:

- **Create a new workspace**:
  ```bash
  terraform workspace new <workspace_name>
  ```
- **List all workspaces**:
  ```bash
  terraform workspace list
  ```
- **Select a workspace**:
  ```bash
  terraform workspace select <workspace_name>
  ```

#### Example Setup

This example demonstrates how to set up Terraform workspaces for creating an EC2 instance in dev, test, and prod environments.

##### Step 1: Define Variables

Create a `variables.tf` file to define common variables.

```hcl
# variables.tf
variable "aws_region" {
  description = "AWS region to deploy resources"
  type        = string
  default     = "us-east-1"
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
}

variable "ami_id" {
  description = "AMI ID to use for the EC2 instance"
  type        = string
}
```

##### Step 2: Define Provider Configuration

Create a `provider.tf` file to configure the AWS provider.

```hcl
# provider.tf
provider "aws" {
  region = var.aws_region
}
```

##### Step 3: Define EC2 Instance Resource

Create a `main.tf` file to define the EC2 instance resource.

```hcl
# main.tf
resource "aws_instance" "example" {
  ami           = var.ami_id
  instance_type = var.instance_type

  tags = {
    Name = "ExampleInstance-${terraform.workspace}"
  }
}
```

##### Step 4: Define Environment-Specific Variables

Create a `terraform.tfvars` file for each environment to specify environment-specific variables.

- `dev.tfvars`
  ```hcl
  ami_id        = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  ```

- `test.tfvars`
  ```hcl
  ami_id        = "ami-0abcdef1234567890"
  instance_type = "t2.small"
  ```

- `prod.tfvars`
  ```hcl
  ami_id        = "ami-0123456789abcdef0"
  instance_type = "t2.medium"
  ```

##### Step 5: Initialize Terraform and Create Workspaces

Initialize Terraform and create the necessary workspaces.

```bash
terraform init

terraform workspace new dev
terraform workspace new test
terraform workspace new prod
```

##### Step 6: Apply Configuration

Select each workspace and apply the configuration using the corresponding `terraform.tfvars` file.

- **Dev Environment**:
  ```bash
  terraform workspace select dev
  terraform apply -var-file=dev.tfvars
  ```

- **Test Environment**:
  ```bash
  terraform workspace select test
  terraform apply -var-file=test.tfvars
  ```

- **Prod Environment**:
  ```bash
  terraform workspace select prod
  terraform apply -var-file=prod.tfvars
  ```
