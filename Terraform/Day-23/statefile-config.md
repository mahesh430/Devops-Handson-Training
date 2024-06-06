
---

# Terraform Remote State and Backend Configuration with AWS S3 and DynamoDB

This guide will walk you through configuring a remote state file and backend for Terraform using AWS S3 for state storage and DynamoDB for state locking.

## Prerequisites

Before you begin, ensure you have the following:
- AWS CLI configured with appropriate permissions.
- Terraform installed.

## Steps

### 1. Create S3 Bucket for Remote State Storage

1. Open the AWS Management Console.
2. Navigate to the S3 service.
3. Create a new bucket (e.g., `my-terraform-state-bucket`).
4. Configure the bucket with appropriate permissions and settings to ensure it is secure and only accessible by your team.

**Example AWS CLI Command:**

```sh
aws s3api create-bucket --bucket my-terraform-state-bucket --region us-west-2
```

### 2. Create DynamoDB Table for State Locking

1. Open the AWS Management Console.
2. Navigate to the DynamoDB service.
3. Create a new table named `terraform-lock-table`.
4. Set the primary key as `LockID` with type `String`.

**Example AWS CLI Command:**

```sh
aws dynamodb create-table --table-name terraform-lock-table --attribute-definitions AttributeName=LockID,AttributeType=S --key-schema AttributeName=LockID,KeyType=HASH --provisioned-throughput ReadCapacityUnits=5,WriteCapacityUnits=5
```

### 3. Configure Terraform Backend

Create or update your Terraform configuration file (`main.tf`) to include the backend configuration for S3 and DynamoDB.

```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "path/to/my/key"
    region         = "us-west-2"
    dynamodb_table = "terraform-lock-table"
    encrypt        = true
  }
}
```

### 4. Initialize Terraform

Run `terraform init` to initialize the backend configuration. This command will set up Terraform to use the S3 bucket and DynamoDB table specified in your configuration.

```sh
terraform init
```

### 5. Verify Configuration

After initialization, Terraform will display a message indicating that it has successfully configured the backend. Verify the configuration by running `terraform plan` or `terraform apply`.

```sh
terraform plan
```
