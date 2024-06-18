---

# Terraform Data Sources Examples

## Introduction

Terraform data sources allow you to fetch information defined outside of Terraform, or defined by another Terraform configuration's state. This information can be used to configure resources within your Terraform configuration.

## Objectives

In this tutorial, you will learn:
- What data sources are in Terraform.
- How to define and use data sources.
- Multiple examples of using data sources to fetch information and use it to configure resources.
- 
## Step 1: Initialize a New Terraform Configuration

1. Create a new directory for your Terraform configuration:

    ```sh
    mkdir terraform-data-sources-examples
    cd terraform-data-sources-examples
    ```

2. Initialize a new Terraform configuration:

    ```sh
    terraform init
    ```

## Example 1: Fetching AWS VPC Information

### Configuration

1. Create a new file named `vpc.tf`:

    ```hcl
    provider "aws" {
      region = "us-west-2"
    }

    data "aws_vpc" "default" {
      default = true
    }

    output "vpc_id" {
      value = data.aws_vpc.default.id
    }
    ```

### Explanation

In this configuration, we define a data source `aws_vpc` to fetch information about the default VPC in the `us-west-2` region. We then output the VPC ID.

### Apply

1. Validate, plan, and apply the configuration:

    ```sh
    terraform validate
    terraform plan
    terraform apply
    ```

## Example 2: Fetching AWS AMI Information

### Configuration

1. Create a new file named `ami.tf`:

    ```hcl
    provider "aws" {
      region = "us-west-2"
    }

    data "aws_ami" "latest_amazon_linux" {
      most_recent = true

      filter {
        name   = "name"
        values = ["amzn2-ami-hvm-*-x86_64-gp2"]
      }

      owners = ["amazon"]
    }

    output "ami_id" {
      value = data.aws_ami.latest_amazon_linux.id
    }
    ```

### Explanation

In this configuration, we define a data source `aws_ami` to fetch information about the latest Amazon Linux 2 AMI in the `us-west-2` region. We filter AMIs by name and owner, then output the AMI ID.

### Apply

1. Validate, plan, and apply the configuration:

    ```sh
    terraform validate
    terraform plan
    terraform apply
    ```

## Example 3: Fetching AWS S3 Bucket Information

### Configuration

1. Create a new file named `s3.tf`:

    ```hcl
    provider "aws" {
      region = "us-west-2"
    }

    data "aws_s3_bucket" "example" {
      bucket = "my-example-bucket"
    }

    output "bucket_arn" {
      value = data.aws_s3_bucket.example.arn
    }
    ```

### Explanation

In this configuration, we define a data source `aws_s3_bucket` to fetch information about an existing S3 bucket named `my-example-bucket`. We then output the bucket ARN.

### Apply

1. Validate, plan, and apply the configuration:

    ```sh
    terraform validate
    terraform plan
    terraform apply
    ```

## Example 4: Fetching AWS Subnet Information

### Configuration

1. Create a new file named `subnet.tf`:

    ```hcl
    provider "aws" {
      region = "us-west-2"
    }

    data "aws_subnet" "selected" {
      filter {
        name   = "tag:Name"
        values = ["my-subnet"]
      }
    }

    output "subnet_id" {
      value = data.aws_subnet.selected.id
    }
    ```

### Explanation

In this configuration, we define a data source `aws_subnet` to fetch information about a subnet with a specific tag name `my-subnet`. We then output the subnet ID.

### Apply

1. Validate, plan, and apply the configuration:

    ```sh
    terraform validate
    terraform plan
    terraform apply
    ```

## Example 5: Using Multiple Data Sources

### Configuration

1. Create a new file named `multi_data_sources.tf`:

    ```hcl
    provider "aws" {
      region = "us-west-2"
    }

    data "aws_vpc" "default" {
      default = true
    }

    data "aws_subnet_ids" "default" {
      vpc_id = data.aws_vpc.default.id
    }

    data "aws_subnet" "first_subnet" {
      id = data.aws_subnet_ids.default.ids[0]
    }

    output "vpc_id" {
      value = data.aws_vpc.default.id
    }

    output "subnet_id" {
      value = data.aws_subnet_ids.default.ids[0]
    }

    output "subnet_cidr" {
      value = data.aws_subnet.first_subnet.cidr_block
    }
    ```

### Explanation

In this configuration, we define multiple data sources:
- `aws_vpc` to fetch the default VPC information.
- `aws_subnet_ids` to fetch all subnet IDs within the default VPC.
- `aws_subnet` to fetch information about the first subnet in the list of subnet IDs.

We then output the VPC ID, the first subnet ID, and the first subnet's CIDR block.

### Apply

1. Validate, plan, and apply the configuration:

    ```sh
    terraform validate
    terraform plan
    terraform apply
    ```

## Conclusion

In this tutorial, you learned how to use Terraform data sources to fetch information about existing infrastructure and use it to configure resources. The examples provided demonstrate various common use cases, including fetching VPC, AMI, S3 bucket, and subnet information, as well as using multiple data sources together.

## Additional Resources

- [Terraform Documentation on Data Sources](https://www.terraform.io/docs/language/data-sources.html)
- [AWS Provider Documentation](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

---

These examples provide a comprehensive guide to using Terraform data sources in various scenarios, showcasing their flexibility and utility.
