To create an AWS Lambda function that lists all EC2 instances in all available regions, you can use the `boto3` library to iterate through each region and list the instances. Below is a simple example of how to achieve this:

### Lambda Function Code

```python
import boto3

def lambda_handler(event, context):
    ec2 = boto3.client('ec2')
    regions = ec2.describe_regions()
    
    all_instances = []

    for region in regions['Regions']:
        region_name = region['RegionName']
        ec2_client = boto3.client('ec2', region_name=region_name)
        instances = ec2_client.describe_instances()

        for reservation in instances['Reservations']:
            for instance in reservation['Instances']:
                all_instances.append({
                    'InstanceId': instance['InstanceId'],
                    'InstanceType': instance['InstanceType'],
                    'State': instance['State']['Name'],
                    'Region': region_name
                })

    return {
        'statusCode': 200,
        'body': all_instances
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
   - In the Lambda function configuration page, paste the code above in the code editor.
   - Make sure the handler is set to `lambda_function.lambda_handler` (or change it according to your file name).
   - Adjust the memory and timeout settings as needed.

3. **Add Permissions**:
   - Ensure the Lambda execution role has the necessary EC2 permissions such as `ec2:DescribeRegions`, `ec2:DescribeInstances`, and other relevant permissions.

4. **Test the Lambda Function**:
   - You can test the function using the built-in test feature in the Lambda console.
   - Click on "Test" and create a new test event (you can use the default template).

### Notes:
- This Lambda function iterates through all regions, lists all EC2 instances, and returns a list of instances with their ID, type, state, and region.
- Adjust the IAM permissions for the Lambda function's execution role to ensure it can access the required EC2 actions.
- Ensure the Lambda function has sufficient memory and timeout settings to handle the potentially large amount of data, especially if you have many instances across multiple regions.
