### Prerequisites:
1. **boto3 Library**: Ensure that the `boto3` library is available in your Lambda environment. If you're using the AWS Management Console to deploy, `boto3` is pre-installed. If you are packaging the Lambda function yourself, make sure to include `boto3`.
2. **IAM Permissions**: The Lambda function needs the necessary IAM permissions to list S3 buckets. Attach a policy with the `s3:ListAllMyBuckets` permission to the Lambda execution role.

### Lambda Function Code:

```python
import boto3

def lambda_handler(event, context):
    s3 = boto3.client('s3')
    response = s3.list_buckets()
    
    # Initialize an empty list to store bucket names
    bucket_names = []
    
    # Iterate over each bucket in the response and add its name to the list
    for bucket in response['Buckets']:
        bucket_names.append(bucket['Name'])
    
    return {
        'statusCode': 200,
        'body': bucket_names
    }

```

### Steps to Deploy the Lambda Function:

1. **Create a Lambda Function**:
   - Go to the AWS Management Console.
   - Navigate to the Lambda service.
   - Click on "Create function".
   - Choose "Author from scratch".
   - Give your function a name and choose the Python runtime.
   - Set up the execution role with the necessary permissions.

2. **Configure the Lambda Function**:
   - In the Lambda function configuration page, paste the code above in the code editor.
   - Make sure the handler is set to `lambda_function.lambda_handler` (or change it according to your file name).
   - Adjust the memory and timeout settings as needed.

3. **Add Permissions**:
   - Ensure the Lambda execution role has the `AmazonS3ReadOnlyAccess` policy attached, or a custom policy with at least `s3:ListAllMyBuckets` permission.

4. **Test the Lambda Function**:
   - You can test the function using the built-in test feature in the Lambda console.
   - Click on "Test" and create a new test event (you can use the default template).

When you run the function, it should output the list of S3 bucket names to the logs and return the list as a JSON response.
