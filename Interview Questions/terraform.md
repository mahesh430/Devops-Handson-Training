### 1. How does Terraform manage state, and why is state management crucial?
Terraform manages state by storing information about your infrastructure in a state file. This state file is used to map Terraform configurations to real-world resources. State management is crucial because it allows Terraform to:
1. **Track Resource Metadata**: Maintain information about resources, enabling updates and changes without recreating resources.
2. **Detect Drift**: Identify differences between the actual infrastructure and the Terraform configuration.
3. **Efficient Plan and Apply**: Optimize resource management by knowing what exists and what needs to change.

In summary, Terraform's state management is essential for accurate tracking, efficient operations, and ensuring infrastructure consistency.

### 2. What is the best way to store the Terraform state file?
The best way to store the state file is to keep it in a remote backend like S3. This ensures that whenever multiple people are working on the same code, resource duplication won’t happen.

### 3. What is Terraform state locking?
Whenever we are working on any Terraform code and do `terraform plan`, `apply`, or `destroy`, Terraform will lock the state file to prevent destructive actions.

### 4. What is Terraform backend?
A backend defines where Terraform stores its state data files. Terraform uses persisted state data to keep track of the resources it manages.

Example:
```hcl
terraform {
  backend "s3" {
    bucket         = "my-terraform-state-bucket"
    key            = "path/to/my/terraform.tfstate"
    region         = "us-east-1"
    dynamodb_table = "my-terraform-lock-table"
  }
}
```

### 5. What is a plugin in Terraform?
A plugin is responsible for converting the HCL code into API calls and sending the request to the appropriate provider (AWS, GCP).

### 6. What is a null resource?
As the name suggests, a null resource does not exist on your Cloud Infrastructure. Terraform null_resource can be used in the following scenarios:
- Run shell commands
- Use along with local provisioner and remote provisioner
- Use with Terraform Module, Terraform count, Terraform Data source, Local variables
- Use in output blocks

### 7. What are the types of provisioners?
- **Remote exec**: Run commands using Terraform on a remote server.
- **Local exec**: Run commands using Terraform on the local system.
- **File**: Copy files from local to remote machines.

### 8. What is the use of Terraform module? How to Create a Module ? How to Call a Module ?

Terraform modules serve several important purposes:
- **Create Reusable Modules**: Standardize code by creating reusable modules.
- **Reduce Code Duplication**: Avoid repeating the same code in multiple places.
- **Version Modules**: Maintain consistent use by versioning modules.

#### How to Create a Module
1. **Create a directory** for the module (e.g., `ec2_module`).
2. **Define resources** inside this directory (e.g., `main.tf`, `variables.tf`, and `outputs.tf`).

**Example**:
`main.tf`
```hcl
resource "aws_instance" "example" {
  ami           = var.ami
  instance_type = var.instance_type

  tags = {
    Name = var.instance_name
  }
}
```

`variables.tf`
```hcl
variable "ami" {
  type = string
}

variable "instance_type" {
  type = string
}

variable "instance_name" {
  type = string
}
```

`outputs.tf`
```hcl
output "instance_id" {
  value = aws_instance.example.id
}
```

#### How to Call a Module
1. **Reference the module** in your Terraform configuration using the `module` block.

**Example**:
```hcl
module "ec2_instance" {
  source        = "./ec2_module"   # Path to the module directory
  ami           = "ami-0abcdef1234567890"
  instance_type = "t2.micro"
  instance_name = "example-instance"
}
```

In this example:
- The `source` attribute specifies the path to the module directory.
- The other attributes (`ami`, `instance_type`, `instance_name`) are inputs to the module, defined in the `variables.tf` file of the module.
- Create reusable modules to standardize code.
- Reduce code duplication.
- Version modules for consistent use.

### 9. What does "terraform refresh do"?
Terraform refresh (deprecated) attempts to update the Terraform state file to match the actual state of your infrastructure resources. It does not modify the infrastructure itself.
### 9. What does "terraform taint" do?
Terraform taint marks a resource as potentially corrupted and schedules it for recreation on the next terraform apply.
While it works, it's deprecated. Use terraform apply -replace instead for better control.
### 9. How can you get a list of Terraform resources of a given folder with terraform code?
 terraform state list
### 9. Can you move terraform state from one place to another?
terraform state mv
### 9. What does terraform init command do?
Terraform init initializes a Terraform working directory. In short, it gets your directory ready to use Terraform by:

 - Installing required plugins for interacting with cloud providers (e.g., AWS, Azure).
 - Downloading necessary modules.
 - Setting up the backend configuration (optional).

### 10. Could you explain the differences between the count and for_each meta-arguments in Terraform?
- **`count`**:
  - Used for creating multiple instances of a resource or module based on a numeric value.
  - Allows conditional creation of resources using `count = 0` (resource not created) or `count = 1` (resource created).

- **`for_each`**:
  - Used for creating multiple instances of a resource or module based on a set of strings, maps, or lists.
  - Allows more complex iteration, enabling resources to be created for each item in the collection with a unique identifier.

In summary, `count` is simpler and numeric, while `for_each` offers more flexibility with collections.

### 10. How do you manage dependencies between different resources in Terraform configurations?
Dependencies between different resources in Terraform configurations are managed using:
1. **Implicit Dependencies**:
   - Terraform automatically infers dependencies based on resource references within the configuration. For example, if one resource references an attribute of another, Terraform understands that the first resource must be created before the second.

2. **Explicit Dependencies**:
   - Using the `depends_on` meta-argument, you can explicitly specify that a resource depends on another resource or resources. This ensures the dependent resource is created or modified only after the specified resources.

Example of `depends_on`:
```hcl
resource "aws_instance" "example" {
  # configuration
  depends_on = [aws_network_interface.example]
}
```

In summary, Terraform manages dependencies using implicit references and explicit `depends_on` declarations.

### 11. There are 5 people in your team that use Terraform. Some time in the last few days, a resource in AWS changed. How can you find out who did this?

 If it was done via Console, Cloudtrail can tell you. If it was done via Terraform code, git repo AND AWS Cloudtrail can tell you.

### 12. You made a module. One Terraform code uses that module. But, now, you improved that module, but the "caller" code is not compatible with the new version of the module. How can you have both versions of the module in use?
 You can have verions on your modules and the caller code can refer to specific version of the module.

### 13. You have existing infrastructure in AWS that was NOT made by Terraform. How can you bring that infrastructure in Terraform code's control?
If you all want is the "state" to be in Terraform, you can use "terraform import" commnad.

### 14. How can you tackle secrets in Terraform?
Starting version 0.14, you can mark your variables "sensitive". This allows logs of these variables to be masked. You can also integrate Vault with Terraform.

### 15. You have 2 folders of terraform code. Folder A and Folder B. Folder B needs to use output (state) from folder A to create resources. How can you accomplish this?
This has been long-standing problem with Terraform. Terragrunt is one way to get this done. Others have implement custom Python scripts that copies states back and forthe between folders.

### 16. Why would you need "data" resources in Terraform?
To refer to resources that already exists in AWS. For example, list of AMIs in a region.

### 17. Is it safe to store terraform state in a private git repo? Why or why not?
It is NOT safe to store in git repos, because it can hold secrets. Also, it is likely that people will override each other's changes in state.
### 18. You are going to deploy similar resources in Development, Staging and Prod environments. How can you code so that you can deploy to similar Terraform code with repeating your code.

You can use Terraform modules and workspaces:

- **Modules:** Create a module for your resources and reuse it with different parameters for each environment.
- **Workspaces:** Manage multiple environments using the same configuration and switch between them using workspaces.

This approach avoids code duplication and maintains consistency across environments.
### 19. What is a provider and why do you need it?
Terraform doesn't directly create resources in the cloud. It interacts with provider (given by AWS, GCP, etc.), which enables communication between Terraform and the cloud provider APIs (AWS, GCP etc.).
Using the same idea, Terraform can also deploy resources in non-cloud applications as long as it has a provider (e.g. Hashicorp Vault) 
```bash
provider "aws" {
  region = "us-east-1"
}
```

### 20. Can a module call another module?

Yes, Terraform modules can call other modules, but it is not recommended

``` bash
# main.tf
module "vpc" {
  source = "./modules/vpc"
  cidr_block = "10.0.0.0/16"
}

module "web_server" {
  source = "./modules/web_server"
  vpc_id = module.vpc.vpc_id
}
```

### 21. Why do we need terraform.tfvars file?

If you do not hard code variables, you can set values in terraform.tfvars files (different values per environment). This way, your code doesn't change and you can follow DRY principle.

### 22. What negative impact does it have if you remove .terraform folder?
None. Terraform will simply download everything when you run terraform init command
### Using Terraform , you have deployed 6 resources in AWS. However, a developer deleted on of them via AWS Console. Turns out that , that resource was not needed any way. How can you make your terraform code and terraform state sync up now?
 - terraform state rm resource_name &
 - remove the relevant part of the code that creates the deleted resource
### How would switch between versions of Terraform?
There are tools for managing Terraform versions. Popular options include:

tfswitch: A command-line tool that lets you download and switch between Terraform versions easily.
tfenv: Another popular version manager for Terraform.
### Which Terraform command ensures my code follows consistent formatting guidelines?
terraform fmt
### Is there a tool that can look for security vulnerabilities in your terraform code?
Yes. tfsec


alias 

### write a terraform code to create ec2 instances using for each loop and dynamic block examples
``` bash
# main.tf
provider "aws" {
  region = var.aws_region # Specify the desired region
}

locals {
  name = "${var.prefix}-${var.env}-${var.aws_region}-aws"
  env = var.env
}



# Security group creation using dynamic blocks
resource "aws_security_group" "dynamic_sg" {
  name        = "dynamic-sg"
  description = "Dynamic Security Group"
  vpc_id      = "vpc-0970dbf0432aa69f5"  # Replace with your VPC ID

  dynamic "ingress" {
    for_each = var.security_group_rules
    content {
      from_port   = ingress.value.from_port 
      to_port     = ingress.value.to_port
      protocol    = ingress.value.protocol
      cidr_blocks = [ingress.value.cidr]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}


# Single instance creation using the map variable
resource "aws_instance" "example" {
  count = var.create_instance ? 1 : 0
  # ami           = "ami-08a0d1e16fc3f61ea"
 #  ami           = lookup(var.ami_ids, var.aws_region, "ami-08a0d1e16fc3f61e4f")
  instance_type = "t2.micro"
  vpc_security_group_ids = [aws_security_group.dynamic_sg.id]

  tags = {
    Name = local.name
  }
}
```
