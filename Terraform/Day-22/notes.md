### Terraform Variables and Outputs

#### 1. Creating Variables

**Step 1: Define Variables**

Create a file named `variables.tf` to define your variables.

```hcl
# variables.tf

variable "region" {
  description = "The AWS region to deploy resources"
  type        = string
}

variable "instance_type" {
  description = "The type of EC2 instance"
  type        = string
}

variable "key_name" {
  description = "The name of the key pair"
  type        = string
}
```

**Step 2: Define Outputs**

Create a file named `outputs.tf` to define your outputs.

```hcl
# outputs.tf

output "instance_id" {
  description = "The ID of the EC2 instance"
  value       = aws_instance.example.id
}

output "instance_public_ip" {
  description = "The public IP of the EC2 instance"
  value       = aws_instance.example.public_ip
}
```

#### 2. Creating EC2 Resource with Variables

**Step 3: Use Variables in Resource**

In your main configuration file, typically `main.tf`, use the variables.

```hcl
# main.tf

provider "aws" {
  region = var.region
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"  # Replace with your AMI ID
  instance_type = var.instance_type
  key_name      = var.key_name

  tags = {
    Name = "ExampleInstance"
  }
}
```

#### 3. Using `tfvars` Files

**Step 4: Create Environment-specific `tfvars` Files**

Create separate `tfvars` files for different environments.

```hcl
# dev.tfvars

region        = "us-west-2"
instance_type = "t2.micro"
key_name      = "dev-key-pair"
```

```hcl
# test.tfvars

region        = "us-east-1"
instance_type = "t3.small"
key_name      = "test-key-pair"
```

```hcl
# prd.tfvars

region        = "us-west-1"
instance_type = "t3.medium"
key_name      = "prd-key-pair"
```

#### 4. Passing Runtime Variables

**Step 5: Pass Variables at Runtime**

You can specify the appropriate `tfvars` file for each environment at runtime.

```sh
terraform apply -var-file="dev.tfvars"
```

```sh
terraform apply -var-file="test.tfvars"
```

```sh
terraform apply -var-file="prd.tfvars"
```


### Step 4: Apply the Configuration

Run the following command to apply the configuration for a specific environment.

#### For Dev Environment

```sh
terraform apply -var-file="dev.tfvars"
```

#### For Test Environment

```sh
terraform apply -var-file="test.tfvars"
```

#### For Production Environment

```sh
terraform apply -var-file="prd.tfvars"
```

### Outputs

After the apply completes, Terraform will output the EC2 instance ID and public IP address.

### Cleaning Up

To destroy the resources created by this configuration, run:

#### For Dev Environment

```sh
terraform destroy -var-file="dev.tfvars"
```

#### For Test Environment

```sh
terraform destroy -var-file="test.tfvars"
```

#### For Production Environment

```sh
terraform destroy -var-file="prd.tfvars"
```
```

This structured approach ensures you can manage different environments effectively using Terraform and document the process clearly in your GitHub repository.
