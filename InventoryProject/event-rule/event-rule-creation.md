To create an EventBridge rule that triggers your Lambda function every minute, follow these steps through the AWS Management Console:

### Step 1: Create the EventBridge Rule
1. **Open the Amazon EventBridge console**.
2. **In the navigation pane**, choose **Rules**.
3. **Click on "Create rule"**.

### Step 2: Configure the Rule
1. **Define the rule name and description**:
   - **Name**: `InvokeLambdaEveryMinute`
   - **Description**: `Rule to trigger Lambda function every minute`

2. **Define the rule pattern**:
   - **Event Source**: **EventBridge (CloudWatch Events)**
   - **Rule type**: **Schedule**
   - **Schedule pattern**: **Rate-based scheduling** or **Cron-based scheduling**
     - **Rate expression**: `1 minute`

### Step 3: Add Target to the Rule
1. **Target**: **Lambda function**
   - **Function**: Select your Lambda function from the dropdown list.
   
2. **Configure Input (Optional)**:
   - If you need to pass specific input to your Lambda function, you can configure it here.

### Step 4: Create the Rule
1. **Click on "Create"** to finalize the rule creation.

### Verifying the Rule
1. **Go to the Lambda console**.
2. **Select your Lambda function**.
3. **Check the "Monitoring" tab** to see invocations triggered by the new EventBridge rule.

### Detailed Step-by-Step with Screenshots

#### Step 1: Open EventBridge Console
1. **Navigate to the EventBridge console** from the AWS Management Console.

#### Step 2: Create Rule
1. Click on **"Create rule"**.
2. Enter a **name** (`InvokeLambdaEveryMinute`) and **description**.

#### Step 3: Define Schedule
1. **Rule type**: Select **Schedule**.
2. **Schedule pattern**:
   - For **rate-based**: `1 minute`

   ![Schedule Pattern](https://docs.aws.amazon.com/eventbridge/latest/userguide/images/rule-schedule.png)

#### Step 4: Add Target
1. **Target**: Choose **Lambda function**.
2. **Function**: Select your Lambda function from the dropdown.

   ![Add Target](https://docs.aws.amazon.com/eventbridge/latest/userguide/images/rule-target.png)

#### Step 5: Create Rule
1. Click **Create**.

### Monitoring the Rule
1. **Navigate to the Lambda console**.
2. **Select your Lambda function**.
3. Under the **Monitoring** tab, you should see the invocations happening every minute.

This process will set up an EventBridge rule that triggers your Lambda function every minute, ensuring your DynamoDB table is updated regularly.
