### Terraform Modules: Teaching Notes

#### **Overview**

Modules in Terraform are used to create reusable and maintainable infrastructure configurations. They enable you to organize your code, simplify complex setups, and promote reusability and consistency across your infrastructure deployments.

#### **Topics to Cover**

1. **Introduction to Terraform Modules**
2. **Creating Local Modules**
3. **Using Remote Modules**
4. **Module Versioning**
5. **Module Best Practices**
6. **Module Registry**
7. **Hands-On Examples**

---

### **1. Introduction to Terraform Modules**

#### **Definition**
- A module is a container for multiple resources that are used together. A module can consist of a single file or a collection of multiple files.
- Modules can be nested: a module can call another module which can call another, etc.

#### **Benefits**
- Reusability: Write once, use multiple times.
- Maintainability: Easier to manage and update.
- Organization: Structuring code to improve readability and management.

---

### **2. Creating Local Modules**

#### **Structure of a Module**
A typical module structure:
```
module_name/
  ├── main.tf
  ├── variables.tf
  ├── outputs.tf
  ├── README.md
```

#### **Example**

**File Structure**:
```
my-vpc/
  ├── main.tf
  ├── variables.tf
  ├── outputs.tf
  ├── README.md
```

**main.tf**:
```hcl
resource "aws_vpc" "main" {
  cidr_block = var.cidr_block

  tags = {
    Name = var.vpc_name
  }
}
```

**variables.tf**:
```hcl
variable "cidr_block" {
  description = "The CIDR block for the VPC"
  type        = string
}

variable "vpc_name" {
  description = "The name of the VPC"
  type        = string
}
```

**outputs.tf**:
```hcl
output "vpc_id" {
  description = "The ID of the VPC"
  value       = aws_vpc.main.id
}
```

**Using the Module**:
```hcl
module "vpc" {
  source     = "./my-vpc"
  cidr_block = "10.0.0.0/16"
  vpc_name   = "my-vpc"
}
```

---

### **3. Using Remote Modules**

#### **Example**

**Using a Module from the Terraform Registry**:
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"

  name = "my-vpc"
  cidr = "10.0.0.0/16"

  azs             = ["us-west-1a", "us-west-1b", "us-west-1c"]
  private_subnets = ["10.0.1.0/24", "10.0.2.0/24", "10.0.3.0/24"]
  public_subnets  = ["10.0.101.0/24", "10.0.102.0/24", "10.0.103.0/24"]

  enable_nat_gateway = true
  single_nat_gateway = true
}
```

---

### **4. Module Versioning**

#### **Importance**
- Ensures consistency and stability across different environments.
- Facilitates controlled updates and rollback capabilities.

**Specifying Version**:
```hcl
module "vpc" {
  source  = "terraform-aws-modules/vpc/aws"
  version = "2.77.0"
  ...
}
```

---

### **5. Module Best Practices**

- **Use Meaningful Names**: Name modules and variables clearly.
- **Document Modules**: Include a README.md with usage instructions and examples.
- **Output Important Values**: Ensure important resource attributes are exposed via outputs.
- **Use Version Control**: Keep your modules in a version control system and tag releases.
- **Handle Dependencies**: Manage dependencies between modules appropriately.

---

### **6. Module Registry**

#### **Terraform Registry**
- A central repository to find, publish, and reuse Terraform modules.
- Modules in the registry follow a standardized naming convention and include versioning.

**Example Module in Registry**:
- [VPC Module](https://registry.terraform.io/modules/terraform-aws-modules/vpc/aws/latest)

---

### **7. Hands-On Examples**

#### **Example 1: Creating and Using a Local Module**

1. **Create a VPC Module**:
    - Define resources in `main.tf`, variables in `variables.tf`, and outputs in `outputs.tf`.
2. **Use the VPC Module**:
    - Reference the local module in your main configuration.

#### **Example 2: Using a Remote Module from the Registry**

1. **Choose a Module**:
    - Select a module from the Terraform Registry.
2. **Implement the Module**:
    - Define the module source and version in your configuration file.

#### **Example 3: Creating a Module Repository on GitHub**

1. **Create a GitHub Repository**:
    - Structure the repository with `main.tf`, `variables.tf`, `outputs.tf`, and `README.md`.
2. **Reference the GitHub Module**:
    - Use the module by specifying the GitHub URL:
    ```hcl
    module "vpc" {
      source = "git::https://github.com/username/repo_name.git"
      ...
    }
    ```

---

### **GitHub Documentation Approach**

**README.md Example**:
```markdown
# My VPC Module

This module creates a VPC with public and private subnets.

## Usage

```hcl
module "vpc" {
  source     = "./my-vpc"
  cidr_block = "10.0.0.0/16"
  vpc_name   = "my-vpc"
}
```

## Inputs

| Name       | Description             | Type   | Default | Required |
|------------|-------------------------|--------|---------|----------|
| cidr_block | The CIDR block for the VPC | string | n/a     | yes      |
| vpc_name   | The name of the VPC       | string | n/a     | yes      |

## Outputs

| Name   | Description         |
|--------|---------------------|
| vpc_id | The ID of the VPC   |
```

### References
- [Terraform Documentation](https://www.terraform.io/docs)
- [Terraform Registry](https://registry.terraform.io)
- [Terraform GitHub Examples](https://github.com/terraform-providers)

By covering these topics and using examples, you can provide a comprehensive and practical understanding of Terraform modules to your class.
