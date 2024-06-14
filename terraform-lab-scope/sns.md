
```markdown
# SNS Module

This module creates an SNS topic with an email subscription.

## Resources

| Name                              | Type                        |
|-----------------------------------|-----------------------------|
| `aws_sns_topic.topic`             | SNS Topic                   |
| `aws_sns_topic_subscription.email` | SNS Topic Email Subscription|

## Inputs

| Name           | Description                            | Type   | Default | Required |
|----------------|----------------------------------------|--------|---------|----------|
| `topic_name`   | The name of the SNS topic              | string | n/a     | yes      |
| `email_address`| The email address for the SNS subscription | string | n/a     | yes      |
| `environment`  | The environment for the SNS topic      | string | n/a     | yes      |

## Outputs

| Name       | Description             |
|------------|-------------------------|
| `topic_arn`| The ARN of the SNS topic|
```
