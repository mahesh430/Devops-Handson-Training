
### Repository for the EC2 Module

1. **Create the Directory Structure:**

   ```sh
   mkdir -p terraform-ec2-module/modules/ec2
   cd terraform-ec2-module
   ```

2. **Create EC2 Module Files:**

   - **`modules/ec2/main.tf`**
     ```hcl
     resource "aws_instance" "ec2_instance" {
       ami           = var.ami_id
       instance_type = var.instance_type

       tags = {
         Name = var.instance_name
       }
     }
     ```

   - **`modules/ec2/variables.tf`**
     ```hcl
     variable "ami_id" {
       description = "The AMI ID to use for the instance"
       type        = string
     }

     variable "instance_type" {
       description = "The type of instance to use"
       type        = string
     }

     variable "instance_name" {
       description = "The name to assign to the instance"
       type        = string
     }
     ```

   - **`modules/ec2/outputs.tf`**
     ```hcl
     output "instance_id" {
       description = "The ID of the EC2 instance"
       value       = aws_instance.ec2_instance.id
     }

     output "instance_public_ip" {
       description = "The public IP address of the EC2 instance"
       value       = aws_instance.ec2_instance.public_ip
     }
     ```

3. **Initialize Git Repository and Push to GitHub:**

   ```sh
   git init
   git add .
   git commit -m "Initial commit of EC2 module"
   git remote add origin git@github.com:mahesh430/terraform-ec2-module.git
   git push -u origin main
   ```

### New Project to Access the Remote Module

1. **Create a New Project Directory:**

   ```sh
   mkdir my-terraform-project
   cd my-terraform-project
   ```

2. **Create Terraform Configuration Files:**

   - **`main.tf`**
     ```hcl
     module "ec2_instance" {
       source        = "git::https://github.com/mahesh430/terraform-ec2-module.git//modules/ec2?ref=main"
       ami_id        = var.ami_id
       instance_type = var.instance_type
       instance_name = var.instance_name
     }
     ```

   - **`variables.tf`**
     ```hcl
     variable "ami_id" {
       description = "The AMI ID to use for the instance"
       type        = string
     }

     variable "instance_type" {
       description = "The type of instance to use"
       type        = string
     }

     variable "instance_name" {
       description = "The name to assign to the instance"
       type        = string
     }
     ```

   - **`outputs.tf`**
     ```hcl
     output "instance_id" {
       description = "The ID of the EC2 instance"
       value       = module.ec2_instance.instance_id
     }

     output "instance_public_ip" {
       description = "The public IP address of the EC2 instance"
       value       = module.ec2_instance.instance_public_ip
     }
     ```

   - **`terraform.tfvars`**
     ```hcl
     ami_id        = "ami-0c55b159cbfafe1f0"
     instance_type = "t2.micro"
     instance_name = "MyEC2Instance"
     ```

3. **Initialize Git Repository and Push to GitHub:**

   ```sh
   git init
   git add .
   git commit -m "Initial commit of project to use EC2 module"
   git remote add origin git@github.com:mahesh430/my-terraform-project.git
   git push -u origin main
   ```

### Summary

You now have two repositories:
1. **`terraform-ec2-module`** for the EC2 module.
2. **`my-terraform-project`** to access and use the remote EC2 module.

The `my-terraform-project` repository can be structured to use the `terraform-ec2-module` from GitHub, and you can manage and update each repository independently. This setup ensures a clear separation of the module definition and its usage.
