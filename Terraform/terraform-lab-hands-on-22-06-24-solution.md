### Terraform Lab Requirement: Comprehensive Scenario

#### Scenario Overview

You are tasked with setting up a scalable, high-availability web application infrastructure on AWS using Terraform. The infrastructure will include multiple EC2 instances, a load balancer, security groups, and other necessary resources. Additionally, you will need to use Terraform provisioners, null resources, import existing resources into the state, and leverage complex variable types (list, map, set) along with meta-arguments (`count`, `for_each`) to achieve dynamic and reusable configurations.

#### Scope of Requirements

1. **Infrastructure Components**:
   - **EC2 Instances**: Create multiple EC2 instances using `count` and `for_each`.
   - **Security Groups**: Define security groups to allow SSH, HTTP, and HTTPS traffic.
   - **Load Balancer**: Set up an AWS Application Load Balancer to distribute traffic across the EC2 instances.
   - **Provisioners**: Use provisioners to install and configure web servers on the EC2 instances.
   - **Null Resource**: Implement a `null_resource` to perform additional configuration tasks.
   - **Importing Resources**: Import an existing S3 bucket into the Terraform state.

2. **Variables**:
   - Use lists, maps, and sets to manage variables dynamically.
   - Define variables for instance types, AMI IDs, security group rules, and more.

3. **Outputs**:
   - Output the public IP addresses of the EC2 instances.
   - Output the DNS name of the load balancer.
   - Output the security group IDs.

---

### Detailed Lab Setup

#### 1. Providers and Variables

**providers.tf**:

```hcl
provider "aws" {
  region = "us-east-1"
}
```

**variables.tf**:

```hcl
variable "instance_count" {
  description = "Number of EC2 instances to create"
  type        = number
  default     = 3
}

variable "instance_type" {
  description = "Type of EC2 instance"
  type        = string
  default     = "t2.micro"
}

variable "ami_id" {
  description = "AMI ID for the EC2 instances"
  type        = string
  default     = "ami-0c55b159cbfafe1f0" # Amazon Linux 2
}

variable "security_group_rules" {
  description = "Map of security group rules"
  type        = map(map(string))
  default = {
    "ssh" = {
      from_port = 22
      to_port   = 22
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    }
    "http" = {
      from_port = 80
      to_port   = 80
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    }
    "https" = {
      from_port = 443
      to_port   = 443
      protocol  = "tcp"
      cidr      = "0.0.0.0/0"
    }
  }
}
```

#### 2. Security Groups

**security_groups.tf**:

```hcl
resource "aws_security_group" "web_sg" {
  name        = "web-sg"
  description = "Security group for web servers"

  dynamic "ingress" {
    for_each = var.security_group_rules
    content {
      from_port   = ingress.value["from_port"]
      to_port     = ingress.value["to_port"]
      protocol    = ingress.value["protocol"]
      cidr_blocks = [ingress.value["cidr"]]
    }
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}
```

#### 3. EC2 Instances

**instances.tf**:

```hcl
resource "aws_instance" "web" {
  count         = var.instance_count
  ami           = var.ami_id
  instance_type = var.instance_type
  key_name      = "my_key" # Ensure this key exists in your AWS account
  security_groups = [aws_security_group.web_sg.name]

  provisioner "remote-exec" {
    inline = [
      "sudo yum update -y",
      "sudo yum install -y nginx",
      "sudo systemctl start nginx",
      "sudo systemctl enable nginx"
    ]

    connection {
      type        = "ssh"
      user        = "ec2-user"
      private_key = file("~/.ssh/my_key")
      host        = self.public_ip
    }
  }

  tags = {
    Name = "WebServer-${count.index}"
  }
}
```

#### 4. Load Balancer

**load_balancer.tf**:

```hcl
resource "aws_lb" "web_lb" {
  name               = "web-lb"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.web_sg.id]
  subnets            = ["subnet-12345678", "subnet-87654321"] # Replace with your subnet IDs

  enable_deletion_protection = false
}

resource "aws_lb_target_group" "web_tg" {
  name     = "web-tg"
  port     = 80
  protocol = "HTTP"
  vpc_id   = "vpc-12345678" # Replace with your VPC ID
}

resource "aws_lb_listener" "web_listener" {
  load_balancer_arn = aws_lb.web_lb.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.web_tg.arn
  }
}

resource "aws_lb_target_group_attachment" "web_tg_attachment" {
  count            = var.instance_count
  target_group_arn = aws_lb_target_group.web_tg.arn
  target_id        = aws_instance.web[count.index].id
  port             = 80
}
```

#### 5. Null Resource

**null_resource.tf**:

```hcl
resource "null_resource" "configure_web" {
  triggers = {
    instance_ids = join(",", aws_instance.web[*].id)
  }

  provisioner "local-exec" {
    command = "echo 'Web servers are configured' > web_configuration.txt"
  }
}
```

#### 6. Importing Resources

You can import an existing S3 bucket into your Terraform state:

```sh
terraform import aws_s3_bucket.existing_bucket my-bucket-name
```

**import.tf**:

```hcl
resource "aws_s3_bucket" "existing_bucket" {
  bucket = "my-bucket-name"
}
```

#### 7. Outputs

**outputs.tf**:

```hcl
output "instance_public_ips" {
  value = aws_instance.web[*].public_ip
}

output "load_balancer_dns" {
  value = aws_lb.web_lb.dns_name
}

output "security_group_id" {
  value = aws_security_group.web_sg.id
}
```

### Summary

This lab covers:

- Creating multiple EC2 instances with `count`.
- Using dynamic blocks for security group rules.
- Setting up a load balancer and target group.
- Using provisioners to configure instances.
- Implementing a null resource for additional tasks.
- Importing an existing resource into the Terraform state.
- Using various variable types (list, map, set).
- Outputting important resource information.

By completing this lab, you will gain practical experience with several key features and best practices in Terraform.
