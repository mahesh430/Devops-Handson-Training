### Prerequisites
- Ensure your DynamoDB table `inventory-env` exists and has data.
- You have appropriate IAM roles that allow API Gateway to access DynamoDB.

### Step 1: Create the REST API in API Gateway

#### Create a New REST API
1. Open the **API Gateway console**.
2. Click on **Create API**.
3. Choose **REST API** and click **Build**.
4. Provide a name for the API, e.g., `InventoryAPI`.
5. Click **Create API**.

### Step 2: Create the Resource and Method for Fetching All Environments

#### Create Resource
1. In the **Resources** section, click on the **Actions** dropdown and select **Create Resource**.
2. Enter `environments` as the resource name and `/environments` as the resource path.
3. Click **Create Resource**.

#### Create GET Method for `environments`
1. Select the newly created `/environments` resource.
2. Click on the **Actions** dropdown and select **Create Method**.
3. Choose `GET` and click the checkmark.
4. Set the **Integration type** to **AWS Service**.
5. Configure the integration request as follows:
   - **AWS Region**: Select your region.
   - **AWS Service**: `dynamodb`.
   - **HTTP method**: `POST`.
   - **Action Type**: `Use action name`.
   - **Action**: `Scan`.

#### Configure Method Request
1. Expand the **Method Request** section.
2. No changes are needed here.

#### Configure Integration Request
1. Expand the **Integration Request** section.
2. In the **Body Mapping Templates** section, click **Add mapping template**.
3. Enter `application/json` and click the checkmark.
4. Paste the following JSON into the mapping template:
    ```json
    {
        "TableName": "inventory-env",
        "ProjectionExpression": "Environment"
    }
    ```
5. Click **Save**.

#### Configure Method Response
1. Expand the **Method Response** section.
2. Ensure that `200` status code is added.
3. Click on the **200** status code and ensure the `application/json` response type is available.

#### Configure Integration Response
1. Expand the **Integration Response** section.
2. Click on the **200** status code.
3. In the **Mapping Templates** section, click **Add mapping template**.
4. Enter `application/json` and click the checkmark.
5. Leave the template blank as the default response format should suffice.

### Step 3: Create the Resource and Method for Fetching Details by Environment

#### Create Resource
1. In the **Resources** section, click on the **Actions** dropdown and select **Create Resource**.
2. Enter `details` as the resource name and `/details` as the resource path.
3. Click **Create Resource**.

#### Create GET Method for `details`
1. Select the newly created `/details` resource.
2. Click on the **Actions** dropdown and select **Create Method**.
3. Choose `GET` and click the checkmark.
4. Set the **Integration type** to **AWS Service**.
5. Configure the integration request as follows:
   - **AWS Region**: Select your region.
   - **AWS Service**: `dynamodb`.
   - **HTTP method**: `POST`.
   - **Action Type**: `Use action name`.
   - **Action**: `Query`.

#### Configure Method Request
1. Expand the **Method Request** section.
2. Click **URL Query String Parameters**.
3. Add a new query string parameter `environment`.

#### Configure Integration Request
1. Expand the **Integration Request** section.
2. In the **Body Mapping Templates** section, click **Add mapping template**.
3. Enter `application/json` and click the checkmark.
4. Paste the following JSON into the mapping template:
    ```json
    {
        "TableName": "inventory-env",
        "KeyConditionExpression": "Environment = :v1",
        "ExpressionAttributeValues": {
            ":v1": {
                "S": "$input.params('environment')"
            }
        }
    }
    ```
5. Click **Save**.

#### Configure Method Response
1. Expand the **Method Response** section.
2. Ensure that `200` status code is added.
3. Click on the **200** status code and ensure the `application/json` response type is available.

#### Configure Integration Response
1. Expand the **Integration Response** section.
2. Click on the **200** status code.
3. In the **Mapping Templates** section, click **Add mapping template**.
4. Enter `application/json` and click the checkmark.
5. Leave the template blank as the default response format should suffice.

### Step 4: Deploy the API

1. In the **Resources** section, click on the **Actions** dropdown and select **Deploy API**.
2. Create a new stage (e.g., `dev`) and click **Deploy**.

### Step 5: Test the APIs

#### Fetch All Environments
1. Navigate to the **Stages** section and select the stage you deployed (e.g., `dev`).
2. Copy the **Invoke URL**.
3. Open a browser or Postman and navigate to: `https://<api-id>.execute-api.<region>.amazonaws.com/<stage>/environments`.
4. You should see a list of environments.

#### Fetch Details by Environment
1. Use the same **Invoke URL**.
2. Open a browser or Postman and navigate to: `https://<api-id>.execute-api.<region>.amazonaws.com/<stage>/details?environment=dev`.
3. You should see details for the specified environment.

This setup will allow you to retrieve all unique `Environment` field values with one API and fetch details based on the `Environment` value with another API.
