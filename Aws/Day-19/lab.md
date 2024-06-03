Below are step-by-step instructions to create everything (CloudWatch Logs, EventBridge, Metrics, and Alarms) through the AWS Management Console.

### Lab 1: CloudWatch Logs

**Objective:**
Monitor and analyze log data from an EC2 instance.

**Steps:**

1. **Create a Log Group:**
   1. Go to the AWS Management Console.
   2. Navigate to the **CloudWatch** service.
   3. In the left-hand menu, click on **Logs** > **Log groups**.
   4. Click on the **Create log group** button.
   5. Enter a name for the log group (e.g., `MyLogGroup`).
   6. Click **Create log group**.

2. **Create a Log Stream:**
   1. Select the log group you just created.
   2. Click on **Actions** > **Create log stream**.
   3. Enter a name for the log stream (e.g., `MyLogStream`).
   4. Click **Create log stream**.

3. **Install CloudWatch Agent on EC2 Instance:**
   1. Connect to your EC2 instance via SSH.
   2. Install the CloudWatch Agent:
      ```sh
      sudo yum install amazon-cloudwatch-agent
      ```

4. **Configure CloudWatch Agent:**
   1. Create a configuration file (`amazon-cloudwatch-agent.json`) with the following content:
      ```json
      {
        "logs": {
          "logs_collected": {
            "files": {
              "collect_list": [
                {
                  "file_path": "/var/log/messages",
                  "log_group_name": "MyLogGroup",
                  "log_stream_name": "MyLogStream"
                }
              ]
            }
          }
        }
      }
      ```
   2. Start the CloudWatch Agent:
      ```sh
      sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
      -a fetch-config -m ec2 -c file:/path/to/your/amazon-cloudwatch-agent.json -s
      ```

### Lab 2: EventBridge for EC2 State Change

**Objective:**
Set up EventBridge to trigger an action when an EC2 instance changes state.

**Steps:**

1. **Create an EventBridge Rule:**
   1. Go to the AWS Management Console.
   2. Navigate to the **EventBridge** service.
   3. In the left-hand menu, click on **Rules**.
   4. Click on the **Create rule** button.
   5. Enter a name for the rule.
   6. For **Define pattern**, select **Event Source** as **AWS events or EventBridge partner events**.
   7. Select **EC2** as the service name.
   8. For **Event Type**, select **EC2 Instance State-change Notification**.
   9. For **Specific states**, select **stopped**.
   10. Click **Next**.

2. **Add Target to the Rule:**
   1. Choose the target (e.g., SNS topic, Lambda function).
   2. Configure the target (e.g., select the SNS topic or Lambda function).

3. **Create Rule:**
   1. Click **Create**.

### Lab 3: CloudWatch Metrics

**Objective:**
Create and monitor custom metrics for an EC2 instance.

**Steps:**

1. **Create a Custom Metric:**
   1. Go to the AWS Management Console.
   2. Navigate to the **CloudWatch** service.
   3. In the left-hand menu, click on **Metrics**.
   4. Click on the **Create metric** button.
   5. Use the AWS CLI or SDKs to publish custom metrics:
      ```sh
      aws cloudwatch put-metric-data --metric-name CPUUtilization --namespace MyCustomMetrics --value 20
      ```

2. **Install CloudWatch Agent on EC2 Instance (if not already installed):**
   1. Connect to your EC2 instance via SSH.
   2. Install the CloudWatch Agent:
      ```sh
      sudo yum install amazon-cloudwatch-agent
      ```

3. **Configure Cloud

Certainly! Below are the steps to create and configure CloudWatch Logs, EventBridge, Metrics, and Alarms for an EC2 instance using the AWS Management Console.

### Lab 1: CloudWatch Logs

**Objective:**
Monitor and analyze log data from an EC2 instance.

**Steps:**

1. **Create a Log Group:**
   1. Go to the AWS Management Console.
   2. Navigate to **CloudWatch**.
   3. In the left-hand menu, click on **Logs** > **Log groups**.
   4. Click on **Create log group**.
   5. Enter a name for the log group (e.g., `MyLogGroup`).
   6. Click **Create log group**.

2. **Create a Log Stream:**
   1. Select the log group you just created.
   2. Click on **Actions** > **Create log stream**.
   3. Enter a name for the log stream (e.g., `MyLogStream`).
   4. Click **Create log stream**.

3. **Install CloudWatch Agent on EC2 Instance:**
   1. Connect to your EC2 instance via SSH.
   2. Install the CloudWatch Agent:
      ```sh
      sudo yum install amazon-cloudwatch-agent
      ```

4. **Configure CloudWatch Agent:**
   1. Create a configuration file (`amazon-cloudwatch-agent.json`) with the following content:
      ```json
      {
        "logs": {
          "logs_collected": {
            "files": {
              "collect_list": [
                {
                  "file_path": "/var/log/messages",
                  "log_group_name": "MyLogGroup",
                  "log_stream_name": "MyLogStream"
                }
              ]
            }
          }
        }
      }
      ```
   2. Start the CloudWatch Agent:
      ```sh
      sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
      -a fetch-config -m ec2 -c file:/path/to/your/amazon-cloudwatch-agent.json -s
      ```

### Lab 2: EventBridge for EC2 State Change

**Objective:**
Set up EventBridge to trigger an action when an EC2 instance changes state.

**Steps:**

1. **Create an EventBridge Rule:**
   1. Go to the AWS Management Console.
   2. Navigate to **EventBridge**.
   3. In the left-hand menu, click on **Rules**.
   4. Click on **Create rule**.
   5. Enter a name for the rule.
   6. For **Define pattern**, select **Event Source** as **AWS events or EventBridge partner events**.
   7. Select **EC2** as the service name.
   8. For **Event Type**, select **EC2 Instance State-change Notification**.
   9. For **Specific states**, select **stopped**.
   10. Click **Next**.

2. **Add Target to the Rule:**
   1. Choose the target (e.g., SNS topic, Lambda function).
   2. Configure the target (e.g., select the SNS topic or Lambda function).

3. **Create Rule:**
   1. Click **Create**.

### Lab 3: CloudWatch Metrics

**Objective:**
Create and monitor custom metrics for an EC2 instance.

**Steps:**

1. **Create a Custom Metric:**
   1. Go to the AWS Management Console.
   2. Navigate to **CloudWatch**.
   3. In the left-hand menu, click on **Metrics**.
   4. Click on **Create metric**.
   5. Use the AWS CLI or SDKs to publish custom metrics:
      ```sh
      aws cloudwatch put-metric-data --metric-name CPUUtilization --namespace MyCustomMetrics --value 20
      ```

2. **Install CloudWatch Agent on EC2 Instance (if not already installed):**
   1. Connect to your EC2 instance via SSH.
   2. Install the CloudWatch Agent:
      ```sh
      sudo yum install amazon-cloudwatch-agent
      ```

3. **Configure CloudWatch Agent:**
   1. Create a configuration file (`amazon-cloudwatch-agent.json`) with the following content:
      ```json
      {
        "metrics": {
          "namespace": "MyCustomMetrics",
          "metrics_collected": {
            "cpu": {
              "measurement": [
                "cpu_usage_idle",
                "cpu_usage_user",
                "cpu_usage_system"
              ]
            }
          }
        }
      }
      ```
   2. Start the CloudWatch Agent:
      ```sh
      sudo /opt/aws/amazon-cloudwatch-agent/bin/amazon-cloudwatch-agent-ctl \
      -a fetch-config -m ec2 -c file:/path/to/your/amazon-cloudwatch-agent.json -s
      ```

### Lab 4: CloudWatch Alarms

**Objective:**
Create a CloudWatch Alarm for an EC2 instance that triggers when CPU utilization exceeds 30%.

**Steps:**

1. **Create an Alarm:**
   1. Go to the AWS Management Console.
   2. Navigate to **CloudWatch**.
   3. In the left-hand menu, click on **Alarms**.
   4. Click on **Create alarm**.
   5. Select the EC2 instance and the `CPUUtilization` metric.
   6. Click **Select metric**.
   7. Set the threshold to 30%.

2. **Configure the Alarm Actions:**
   1. Choose to send a notification to an SNS topic or take other actions.
   2. Configure the SNS topic if not already done.

3. **Create Alarm:**
   1. Click **Create**.

4. **Test the Alarm:**
   1. Generate CPU load on the EC2 instance to trigger the alarm:
      ```sh
      sudo stress --cpu 8 --timeout 300
      ```
   2. Verify if the alarm triggers and the configured actions are executed.

---
