
```markdown
# IAM Module

This module creates an IAM role with a policy that provides read-only access to an S3 bucket.

## Resources

| Name                                      | Type                                 |
|-------------------------------------------|--------------------------------------|
| `aws_iam_role.ec2_role`                   | IAM Role                             |
| `aws_iam_policy.s3_read_only`             | IAM Policy                           |
| `aws_iam_role_policy_attachment.attach_policy` | IAM Role Policy Attachment          |

## Inputs

| Name          | Description                            | Type   | Default | Required |
|---------------|----------------------------------------|--------|---------|----------|
| `role_name`   | The name of the IAM role               | string | n/a     | yes      |
| `policy_name` | The name of the IAM policy             | string | n/a     | yes      |
| `bucket_name` | The name of the S3 bucket              | string | n/a     | yes      |
| `environment` | The environment for the IAM resources  | string | n/a     | yes      |

## Outputs

| Name         | Description             |
|--------------|-------------------------|
| `role_arn`   | The ARN of the IAM role |
| `policy_arn` | The ARN of the IAM policy|
```
