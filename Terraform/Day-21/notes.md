# AWS and Terraform Setup Documentation

## Table of Contents
1. [Creating a User in AWS Console and Adding Admin Permissions](#creating-a-user-in-aws-console-and-adding-admin-permissions)
2. [Install AWS CLI on Windows and Mac](#install-aws-cli-on-windows-and-mac)
3. [Configure AWS CLI on Local](#configure-aws-cli-on-local)
4. [Install Terraform on Windows and Mac](#install-terraform-on-windows-and-mac)
5. [Installing Visual Studio Code on Windows and Mac](#installing-visual-studio-code-on-windows-and-mac)
6. [Brief Introduction to Terraform](#brief-introduction-to-terraform)
7. [Writing a Resource Block to Create an EC2 Instance](#writing-a-resource-block-to-create-an-ec2-instance)
8. [Explaining Resource Block and Provider Block](#explaining-resource-block-and-provider-block)
9. [Running Terraform Commands](#running-terraform-commands)

---

## Creating a User in AWS Console and Adding Admin Permissions

### Steps:
1. **Sign in to the AWS Management Console.**
2. **Navigate to IAM (Identity and Access Management):**
   - Go to the **Services** menu.
   - Select **IAM** under Security, Identity, & Compliance.

3. **Create a New User:**
   - Click on **Users** in the left-hand menu.
   - Click **Add user**.
   - Enter a username.
   - Select the **Access type**: Programmatic access and/or AWS Management Console access.
   - Click **Next: Permissions**.

4. **Attach Policies:**
   - Choose **Attach existing policies directly**.
   - Search for `AdministratorAccess`.
   - Check the `AdministratorAccess` policy.
   - Click **Next: Tags**.

5. **Add Tags (Optional):**
   - Add key-value pairs as tags for the user.
   - Click **Next: Review**.

6. **Review and Create User:**
   - Review the user details.
   - Click **Create user**.

7. **Save User Credentials:**
   - Download the `.csv` file containing the user credentials or copy them.
   - Click **Close**.

---

## Install AWS CLI on Windows and Mac

### Windows:
1. **Download the AWS CLI MSI Installer:**
   - Visit the [AWS CLI installation page](https://aws.amazon.com/cli/).
   - Download the Windows installer.

2. **Run the Installer:**
   - Double-click the downloaded `.msi` file.
   - Follow the on-screen instructions to complete the installation.

3. **Verify the Installation:**
   ```sh
   aws --version
   ```

### Mac:
1. **Use Homebrew to Install AWS CLI:**
   - Open Terminal.

2. **Install Homebrew (if not already installed):**
   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

3. **Install AWS CLI:**
   ```sh
   brew install awscli
   ```

4. **Verify the Installation:**
   ```sh
   aws --version
   ```

---

## Configure AWS CLI on Local

### Steps:
1. **Open Terminal (Mac) or Command Prompt (Windows).**
2. **Run the AWS Configure Command:**
   ```sh
   aws configure
   ```
3. **Enter AWS Access Key ID:** (From the `.csv` file you downloaded when creating the user)
4. **Enter AWS Secret Access Key:** (From the `.csv` file you downloaded when creating the user)
5. **Enter Default Region Name:** (e.g., `us-west-2`)
6. **Enter Default Output Format:** (e.g., `json`)

---

## Install Terraform on Windows and Mac

### Windows:
1. **Download Terraform:**
   - Visit the [Terraform download page](https://www.terraform.io/downloads.html).
   - Download the appropriate zip file for your Windows architecture.

2. **Install Terraform:**
   - Extract the downloaded zip file.
   - Move the extracted `terraform.exe` to a directory included in your system's `PATH`.

3. **Verify the Installation:**
   ```sh
   terraform -v
   ```

### Mac:
1. **Use Homebrew to Install Terraform:**
   - Open Terminal.

2. **Install Terraform:**
   ```sh
   brew tap hashicorp/tap
   brew install hashicorp/tap/terraform
   ```

3. **Verify the Installation:**
   ```sh
   terraform -v
   ```

---

## Installing Visual Studio Code on Windows and Mac

### Windows:
1. **Download the VS Code Installer:**
   - Visit the [VS Code download page](https://code.visualstudio.com/Download).
   - Download the Windows installer.

2. **Run the Installer:**
   - Double-click the downloaded `.exe` file.
   - Follow the on-screen instructions to complete the installation.

### Mac:
1. **Download the VS Code Installer:**
   - Visit the [VS Code download page](https://code.visualstudio.com/Download).
   - Download the Mac installer.

2. **Install VS Code:**
   - Open the downloaded `.dmg` file.
   - Drag the Visual Studio Code icon to the Applications folder.

---

## Brief Introduction to Terraform

Terraform is an open-source infrastructure as code (IaC) software tool created by HashiCorp. It allows users to define and provision infrastructure using a high-level configuration language known as HashiCorp Configuration Language (HCL) or optionally JSON.

### Key Features:
- **Declarative Configuration:** Describe the desired state of infrastructure.
- **Version Control:** Manage infrastructure changes with version control.
- **Resource Provisioning:** Supports multiple cloud providers and services.
- **Execution Plans:** Preview changes before applying.

---

## Writing a Resource Block to Create an EC2 Instance

### Example Resource Block:

```hcl
provider "aws" {
  region = "us-west-2"
}

resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"

  tags = {
    Name = "example-instance"
  }
}
```

### Explanation:
- **Provider Block:** Configures the AWS provider with a specified region.
- **Resource Block:** Defines an EC2 instance resource with:
  - **ami:** The Amazon Machine Image ID.
  - **instance_type:** The instance type (e.g., `t2.micro`).
  - **tags:** Optional tags to apply to the instance.

---

## Running Terraform Commands

### Initialize Terraform:
```sh
terraform init
```
- Initializes the Terraform configuration and installs required providers.

### Plan the Infrastructure Changes:
```sh
terraform plan -out=tfplan
```
- Creates an execution plan, showing what actions Terraform will take.

### Apply the Plan:
```sh
terraform apply tfplan
```
- Applies the changes required to reach the desired state of the configuration.

### Destroy the Infrastructure:
```sh
terraform destroy
```
- Destroys the infrastructure managed by Terraform.

---

### Useful Links:
- [AWS CLI Installation](https://docs.aws.amazon.com/cli/latest/userguide/install-cliv2.html)
- [Terraform Documentation](https://www.terraform.io/docs/index.html)
- [Visual Studio Code Download](https://code.visualstudio.com/Download)

### State File (`terraform.tfstate`)

#### Overview
The Terraform state file (`terraform.tfstate`) is a critical component of Terraform's operation. It records the current state of your infrastructure as known by Terraform, mapping the configuration in your Terraform files to the actual resources provisioned.

#### Key Points
- **Tracks Resources:** Contains details about every resource that Terraform manages, including resource IDs, attributes, and metadata.
- **Synchronization:** Ensures that your configuration matches the real-world infrastructure. When you run `terraform apply`, Terraform compares the desired state (defined in your configuration) with the current state (recorded in the state file) and makes necessary changes.
- **Collaboration:** When working in a team, the state file can be stored remotely (e.g., in an S3 bucket) to allow multiple team members to work on the same infrastructure.

#### Example Content
A typical state file might include JSON-formatted data such as:
```json
{
  "version": 4,
  "terraform_version": "0.14.5",
  "resources": [
    {
      "mode": "managed",
      "type": "aws_instance",
      "name": "example",
      "provider": "provider[\"registry.terraform.io/hashicorp/aws\"]",
      "instances": [
        {
          "schema_version": 0,
          "attributes": {
            "ami": "ami-0c55b159cbfafe1f0",
            "instance_type": "t2.micro",
            "tags": {
              "Name": "example-instance"
            }
          }
        }
      ]
    }
  ]
}
```

### Lock File (`.terraform.lock.hcl`)

#### Overview
The Terraform lock file (`.terraform.lock.hcl`) ensures that Terraform uses the same versions of provider plugins across runs, which helps maintain consistency and reproducibility.

#### Key Points
- **Version Pinning:** Locks the versions of provider plugins to prevent unexpected changes when you run `terraform init` or `terraform apply`.
- **Security:** Helps in avoiding potential breaking changes or security vulnerabilities introduced in newer versions of the provider plugins.
- **Automatic Generation:** Terraform generates and updates this file automatically during initialization and upgrade processes.

#### Example Content
A typical lock file might include HCL-formatted data such as:
```hcl
provider "registry.terraform.io/hashicorp/aws" {
  version     = "3.38.0"
  constraints = ">= 2.7.0, < 4.0.0"
  hashes = [
    "h1:abcdefgh1234567890",
    "h2:ijklmnopqrstuvwxzyz",
    ...
  ]
}
```

### `.terraform` Directory

#### Overview
The `.terraform` directory is a hidden directory created by Terraform within your working directory. It stores various metadata and cached files necessary for Terraform operations.

#### Key Points
- **Provider Plugins:** Contains downloaded provider plugins required for your configuration.
- **Module Cache:** Caches remote modules to improve performance and reduce the need to download them repeatedly.
- **State File Backups:** Stores backup copies of the state file, allowing you to recover from state corruption or other issues.

#### Example Structure
A typical `.terraform` directory structure might look like:
```
.terraform/
├── modules/
│   └── module-xyz/
├── plugins/
│   └── registry.terraform.io/
│       └── hashicorp/
│           └── aws/
│               └── 3.38.0/
│                   └── terraform-provider-aws_v3.38.0_x5
├── providers/
│   └── registry.terraform.io/
│       └── hashicorp/
│           └── aws/
│               └── 3.38.0/
│                   └── linux_amd64/
│                       └── terraform-provider-aws_v3.38.0_x5
├── terraform.tfstate
├── terraform.tfstate.backup
└── terraform.tfstate.lock.info
```

### Summary

- **State File (`terraform.tfstate`):** Tracks the current state of infrastructure, ensuring synchronization between the configuration and the real-world resources.
- **Lock File (`.terraform.lock.hcl`):** Locks provider plugin versions to maintain consistency and security across Terraform runs.
- **`.terraform` Directory:** Stores metadata, cached provider plugins, modules, and state file backups necessary for Terraform operations.

These components are essential for managing and maintaining infrastructure with Terraform effectively. If you have any more questions or need further clarification, feel free to ask!
