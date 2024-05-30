## Cross-Account Access to S3 Buckets from EC2 Instance

This guide provides step-by-step instructions to set up cross-account access to S3 buckets. In this scenario, you have two AWS accounts:

- **Account A**: Contains the S3 buckets.
- **Account B**: Contains the EC2 instance that needs access to the S3 buckets in Account A.

### Prerequisites

- AWS CLI installed and configured.
- Appropriate permissions to create roles and policies in both AWS accounts.

### Step 1: Create an IAM Role in Account A

1. **Create an IAM Role**:
    - Go to the [IAM console](https://console.aws.amazon.com/iam/) in Account A.
    - Select **Roles** and click **Create role**.
    - Choose **Another AWS account** and enter the Account ID of Account B.
    - Attach a policy to grant the necessary S3 permissions. Example policy for read-only access:

    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": [
            "s3:GetObject",
            "s3:ListBucket"
          ],
          "Resource": [
            "arn:aws:s3:::YOUR_BUCKET_NAME",
            "arn:aws:s3:::YOUR_BUCKET_NAME/*"
          ]
        }
      ]
    }
    ```

2. **Set the Trust Relationship**:
    - Set up the trust relationship to allow the IAM role in Account B to assume this role. Example trust policy:

    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Principal": {
            "AWS": "arn:aws:iam::ACCOUNT_B_ID:role/ROLE_NAME_IN_ACCOUNT_B"
          },
          "Action": "sts:AssumeRole"
        }
      ]
    }
    ```

### Step 2: Create an IAM Role in Account B for the EC2 Instance

1. **Create an IAM Role**:
    - Go to the [IAM console](https://console.aws.amazon.com/iam/) in Account B.
    - Select **Roles** and click **Create role**.
    - Choose **AWS Service** and then **EC2**.
    - Attach a policy that allows the role to assume the role in Account A. Example policy:

    ```json
    {
      "Version": "2012-10-17",
      "Statement": [
        {
          "Effect": "Allow",
          "Action": "sts:AssumeRole",
          "Resource": "arn:aws:iam::ACCOUNT_A_ID:role/ROLE_NAME_IN_ACCOUNT_A"
        }
      ]
    }
    ```

2. **Attach the Role to the EC2 Instance**:
    - Launch an EC2 instance in Account B or attach the newly created IAM role to an existing EC2 instance.
    - Go to the [EC2 console](https://console.aws.amazon.com/ec2/).
    - Select your instance, choose **Actions** > **Security** > **Modify IAM role**, and attach the role.

### Step 3: Assume the Role and Access the S3 Bucket from EC2 Instance

1. **Assume the Role Using AWS CLI**:
    - Use the AWS CLI on the EC2 instance to assume the role in Account A.

    ```sh
    ROLE_ARN="arn:aws:iam::ACCOUNT_A_ID:role/ROLE_NAME_IN_ACCOUNT_A"
    SESSION_NAME="MySession"

    ASSUME_ROLE_OUTPUT=$(aws sts assume-role --role-arn $ROLE_ARN --role-session-name $SESSION_NAME)
    ```

2. **Extract the Temporary Credentials**:
    - Extract the AccessKeyId, SecretAccessKey, and SessionToken from the assume-role output.

    ```sh
    AWS_ACCESS_KEY_ID=$(echo $ASSUME_ROLE_OUTPUT | jq -r '.Credentials.AccessKeyId')
    AWS_SECRET_ACCESS_KEY=$(echo $ASSUME_ROLE_OUTPUT | jq -r '.Credentials.SecretAccessKey')
    AWS_SESSION_TOKEN=$(echo $ASSUME_ROLE_OUTPUT | jq -r '.Credentials.SessionToken')
    ```

3. **Export the Temporary Credentials**:
    - Set the environment variables with the temporary credentials.

    ```sh
    export AWS_ACCESS_KEY_ID=$AWS_ACCESS_KEY_ID
    export AWS_SECRET_ACCESS_KEY=$AWS_SECRET_ACCESS_KEY
    export AWS_SESSION_TOKEN=$AWS_SESSION_TOKEN
    ```

4. **Access the S3 Bucket**:
    - Use the AWS CLI to access the S3 bucket in Account A.

    ```sh
    aws s3 ls s3://YOUR_BUCKET_NAME
    ```

### Example Script to Assume Role and Access S3

Here is an example script you can run on your EC2 instance in Account B:

```sh
#!/bin/bash

# Assume the role in Account A
ROLE_ARN="arn:aws:iam::ACCOUNT_A_ID:role/ROLE_NAME_IN_ACCOUNT_A"
SESSION_NAME="MySession"

ASSUME_ROLE_OUTPUT=$(aws sts assume-role --role-arn $ROLE_ARN --role-session-name $SESSION_NAME)

# Extract the temporary credentials
AWS_ACCESS_KEY_ID=$(echo $ASSUME_ROLE_OUTPUT | jq -r '.Credentials.AccessKeyId')
AWS_SECRET_ACCESS_KEY=$(echo $ASSUME_ROLE_OUTPUT | jq -r '.Credentials.SecretAccessKey')
AWS_SESSION_TOKEN=$(echo $ASSUME_ROLE_OUTPUT | jq -r '.Credentials.SessionToken')

# Export the temporary credentials as environment variables
export AWS_ACCESS_KEY_ID
export AWS_SECRET_ACCESS_KEY
export AWS_SESSION_TOKEN

# Access the S3 bucket
aws s3 ls s3://YOUR_BUCKET_NAME
```

### Troubleshooting Tips

- **Verify IAM Role ARN**: Ensure that the ARN for the roles in the trust policy and assume-role command are correct.
- **Check EC2 Instance Role**: Ensure that the correct IAM role is attached to the EC2 instance.
- **Check AWS CLI Configuration**: Verify that the AWS CLI on the EC2 instance is configured correctly and can access AWS services.
- **System Time**: Ensure the system time on your EC2 instance is accurate. An incorrect system time can cause security token issues.
