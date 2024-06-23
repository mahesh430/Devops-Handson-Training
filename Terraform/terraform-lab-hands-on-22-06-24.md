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
### Lab Requirements: Tabular Format

#### Inputs

| Variable Name            | Description                       | Type            | Default Value                                |
|--------------------------|-----------------------------------|-----------------|----------------------------------------------|
| `instance_count`         | Number of EC2 instances to create | `number`        | `1`                                          |
| `instance_type`          | Type of EC2 instance              | `string`        | `t2.micro`                                   |
| `ami_id`                 | AMI ID for the EC2 instances      | `string`        | `ami-0c55b159cbfafe1f0` (Amazon Linux 2)     |
| `security_group_rules`   | Map of security group rules       | `map(map(string))` | `{ "ssh": { "from_port": 22, "to_port": 22, "protocol": "tcp", "cidr": "0.0.0.0/0" }, "http": { "from_port": 80, "to_port": 80, "protocol": "tcp", "cidr": "0.0.0.0/0" }, "https": { "from_port": 443, "to_port": 443, "protocol": "tcp", "cidr": "0.0.0.0/0" } }` |
| `subnets`                | List of subnets for the load balancer | `list(string)` | `["subnet-12345678", "subnet-87654321"]`    |
| `vpc_id`                 | VPC ID for the load balancer      | `string`        | `"vpc-12345678"`                            |
| `key_name`               | SSH key name for EC2 instances    | `string`        | `"my_key"`                                  |
| `private_key_path`       | Path to the private key file for SSH | `string`      | `"~/.ssh/my_key"`                           |

#### Resources

| Resource Type             | Resource Name                  | Description                                           |
|---------------------------|--------------------------------|-------------------------------------------------------|
| `aws_security_group`      | `web_sg`                       | Security group for web servers                        |
| `aws_instance`            | `web`                          | EC2 instances for web servers                         |
| `aws_lb`                  | `web_lb`                       | Application Load Balancer                             |
| `aws_lb_target_group`     | `web_tg`                       | Target group for the load balancer                    |
| `aws_lb_listener`         | `web_listener`                 | Listener for the load balancer                        |
| `aws_lb_target_group_attachment` | `web_tg_attachment`     | Attachments for the target group                      |
| `null_resource`           | `configure_web`                | Null resource for additional configuration tasks      |
| `aws_s3_bucket`           | `existing_bucket`              | Imported existing S3 bucket                           |

#### Outputs

| Output Name              | Description                        | Value                                      |
|--------------------------|------------------------------------|--------------------------------------------|
| `instance_public_ips`    | Public IP addresses of EC2 instances | `aws_instance.web[*].public_ip`            |
| `load_balancer_dns`      | DNS name of the load balancer      | `aws_lb.web_lb.dns_name`                   |
| `security_group_id`      | Security group IDs                 | `aws_security_group.web_sg.id`             |

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
