import json
import boto3
from botocore.exceptions import ClientError

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('inventory-env')

def lambda_handler(event, context):
    try:
        # Dummy data to insert
        items = []
        environments = ['dev', 'test', 'val', 'prod']
        services = ['app', 'spark', 'cicd', 'jenkins', 'ansible', 'kubernetes', 'docker']

        for env in environments:
            for service in services:
                for i in range(1, 11):  # 10 instances per environment and service
                    item = {
                        'HostName': f'{service}-instance-{i}-{env}',
                        'Name': f'{service}-instance-{i}-{env}',
                        'Environment': env,
                        'Service': service,
                        'Customer': f'customer-{i}',
                        'Region': 'us-east-1',
                        'PrivateIP': f'10.0.0.{i}',
                        'PublicIP': f'54.0.0.{i}',
                        'DNSName': f'ip-10-0-0-{i}.ec2.internal',
                        'State': 'running',
                        'ImageId': 'ami-0abcdef1234567890',
                        'InstanceType': 't2.micro',
                        'InstanceTags': {'Key': 'Name', 'Value': f'{service}-instance-{i}-{env}'}
                    }
                    items.append(item)

        with table.batch_writer() as batch:
            for item in items:
                batch.put_item(Item=item)

        return {
            'statusCode': 200,
            'body': json.dumps('50 items inserted successfully')
        }
    except ClientError as e:
        return {
            'statusCode': 500,
            'body': json.dumps('Error inserting items: ' + e.response['Error']['Message'])
        }
    except Exception as e:
        return {
            'statusCode': 500,
            'body': json.dumps(f'Unexpected error: {str(e)}')
        }
