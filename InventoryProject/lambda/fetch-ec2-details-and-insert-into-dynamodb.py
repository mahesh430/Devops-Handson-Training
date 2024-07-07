import json
import boto3
from boto3.dynamodb.conditions import Key

def lambda_handler(event, context):
    # Initialize sessions and resources
    current_session = boto3.session.Session()
    current_region = current_session.region_name
    dynamodb = boto3.resource('dynamodb', region_name=current_region)
    table = dynamodb.Table('AWS_INVENTORY')
    ec2 = boto3.resource('ec2', region_name=current_region)

    instances = ec2.instances.filter(Filters=[{'Name': 'instance-state-name', 'Values': ['running']}])

    my_data = []
    for instance in instances:
        if instance.tags:
            instance_info = {
                'InstanceName': '',
                'Service': '-',
                'Customer': '-',
                'Environment': '-',
                'PublicIP': instance.public_ip_address if instance.public_ip_address else '-',
                'Namespace': '-'
            }

            for tag in instance.tags:
                key, value = tag['Key'], tag['Value']
                if key == 'Name':
                    instance_info['InstanceName'] = value
                elif key == 'Service':
                    instance_info['Service'] = value
                elif key == 'Customer':
                    instance_info['Customer'] = value
                elif key == 'Environment':
                    instance_info['Environment'] = value
                elif key == 'Namespace':
                    instance_info['Namespace'] = value

            instance_tags = ', '.join([f"{key}: {value}" for key, value in instance_info.items()])

            item = {
                'HostName': instance_info['InstanceName'],
                'Name': instance_info['InstanceName'],
                'Environment': instance_info['Environment'],
                'Service': instance_info['Service'],
                'Customer': instance_info['Customer'],
                'Region': current_region,
                'PrivateIP': instance.private_ip_address,
                'PublicIP': instance_info['PublicIP'],
                'DNSName': instance.private_dns_name,
                'State': instance.state['Name'],
                'ImageId': instance.image_id,
                'InstanceType': instance.instance_type,
                'instance_tags': instance_tags
            }

            my_data.append(item)

    # Remove existing items from the DynamoDB table for the current region
    scan = table.query(
        IndexName='Region-index',
        KeyConditionExpression=Key('Region').eq(current_region)
    )
    with table.batch_writer() as batch:
        for item in scan['Items']:
            batch.delete_item(Key={'DNSName': item['DNSName']})

    # Add new items to the DynamoDB table
    with table.batch_writer() as batch:
        for item in my_data:
            batch.put_item(Item=item)

    return {
        'statusCode': 200,
        'body': json.dumps('Lambda function executed successfully')
    }
