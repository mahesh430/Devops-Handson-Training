
```python
import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')

    # Define the instance parameters
    instance_params = {
        'ImageId': 'ami-0abcdef1234567890',  # Replace with a valid AMI ID
        'InstanceType': 't2.micro',           # Replace with the desired instance type
        'MinCount': 1,
        'MaxCount': 1
    }

    # Launch the EC2 instance
    try:
        response = ec2.run_instances(**instance_params)
        instance_id = response['Instances'][0]['InstanceId']
        return {
            'statusCode': 200,
            'body': f'EC2 instance {instance_id} created successfully'
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': f'Error creating EC2 instance: {str(e)}'
        }
```

### Steps to Deploy the Lambda Function

1. **Create a Lambda Function**:
   - Go to the AWS Management Console.
   - Navigate to the Lambda service.
   - Click on "Create function".
   - Choose "Author from scratch".
   - Give your function a name and choose the Python runtime.
   - Set up the execution role with the necessary permissions (attach the required EC2 policies).

2. **Configure the Lambda Function**:
   - In the Lambda function configuration page, paste the simplified code above in the code editor.
   - Make sure the handler is set to `lambda_function.lambda_handler` (or change it according to your file name).
   - Adjust the memory and timeout settings as needed.

3. **Add Permissions**:
   - Ensure the Lambda execution role has the necessary EC2 permissions such as `ec2:RunInstances`, `ec2:DescribeInstances`, and other relevant permissions.

4. **Test the Lambda Function**:
   - You can test the function using the built-in test feature in the Lambda console.
   - Click on "Test" and create a new test event (you can use the default template).

### Notes:
- Replace `ami-0abcdef1234567890` with a valid AMI ID from your AWS account.
- This simplified version removes optional parameters like `KeyName`, `SubnetId`, and `SecurityGroupIds`. You can add them back if needed for your specific use case.
- Ensure your Lambda function has the necessary network configuration if required (e.g., VPC, Subnets, Security Groups).

This simplified Lambda function will create an EC2 instance with the specified AMI ID and instance type.
