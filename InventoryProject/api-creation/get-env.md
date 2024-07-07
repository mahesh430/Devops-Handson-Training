### Step-by-Step Guide to Integrate API Gateway with DynamoDB using Scan Operation

#### Step 1: Create DynamoDB Table (if not already created)

1. **Navigate to the DynamoDB console**:
   - Open the AWS Management Console.
   - Go to the DynamoDB service.

2. **Create the table**:
   - Click on "Create table".
   - Table name: `inventory-env`
   - Partition key: `env` (String)
   - Configure other settings as needed (e.g., read/write capacity mode).
   - Click on "Create".

#### Step 2: Create API Gateway

1. **Navigate to the API Gateway console**:
   - Open the AWS Management Console.
   - Go to the API Gateway service.

2. **Create a new API**:
   - Click on "Create API".
   - Choose "REST API" and select "Build".
   - Choose "New API".
   - Enter a name for your API (e.g., `InventoryAPI`).
   - Click on "Create API".

#### Step 3: Create a Resource and Method in API Gateway

1. **Create a Resource**:
   - In the API Gateway console, select your API.
   - Click on "Resources" in the left-hand menu.
   - Click on "Actions" and select "Create Resource".
   - Enter a Resource Name (e.g., `inventory`).
   - Enter a Resource Path (e.g., `/inventory`).
   - Click on "Create Resource".

2. **Create a GET Method**:
   - Select the newly created resource (`/inventory`).
   - Click on "Actions" and select "Create Method".
   - Choose `GET` from the dropdown menu and click on the checkmark.

#### Step 4: Set Up Integration with DynamoDB

1. **Select Integration Type**:
   - In the GET method setup, choose "AWS Service" for the Integration type.
   - Select "DynamoDB" as the AWS Service.
   - Use the region where your DynamoDB table is located.
   - For Action Type, select "Use a DynamoDB action".
   - For the HTTP method, select `POST`.
   - For the action, select `Scan`.
   - Click on "Save".

2. **Configure Integration Request**:
   - In the Method Execution page, click on "Integration Request".
   - Click on "Mapping Templates".
   - Click on "Add mapping template".
   - Enter `application/json` for the Content-Type and click on the checkmark.

3. **Create a Mapping Template**:
   - In the Input Mapping Template box, enter the following mapping template to perform the scan operation on the `inventory-env` table:

     ```json
     {
       "TableName": "inventory-env"
     }
     ```

#### Step 5: Deploy the API

1. **Create a Deployment Stage**:
   - In the API Gateway console, click on "Actions" and select "Deploy API".
   - Create a new stage (e.g., `dev`).
   - Click on "Deploy".

2. **Invoke the API**:
   - After deployment, note the Invoke URL provided by API Gateway.
   - You can test the API by sending a GET request to the Invoke URL. For example:

     ```
     https://{api-id}.execute-api.{region}.amazonaws.com/dev/inventory
     ```

### Example Terraform Code

If you want to automate the entire setup using Terraform, here’s a simplified example:

```hcl
provider "aws" {
  region = "us-east-1"
}

resource "aws_dynamodb_table" "inventory_env" {
  name           = "inventory-env"
  billing_mode   = "PAY_PER_REQUEST"
  hash_key       = "env"

  attribute {
    name = "env"
    type = "S"
  }
}

resource "aws_api_gateway_rest_api" "inventory_api" {
  name        = "InventoryAPI"
  description = "API for fetching inventory"
}

resource "aws_api_gateway_resource" "inventory_resource" {
  rest_api_id = aws_api_gateway_rest_api.inventory_api.id
  parent_id   = aws_api_gateway_rest_api.inventory_api.root_resource_id
  path_part   = "inventory"
}

resource "aws_api_gateway_method" "inventory_method" {
  rest_api_id   = aws_api_gateway_rest_api.inventory_api.id
  resource_id   = aws_api_gateway_resource.inventory_resource.id
  http_method   = "GET"
  authorization = "NONE"
}

resource "aws_api_gateway_integration" "inventory_integration" {
  rest_api_id             = aws_api_gateway_rest_api.inventory_api.id
  resource_id             = aws_api_gateway_resource.inventory_resource.id
  http_method             = aws_api_gateway_method.inventory_method.http_method
  integration_http_method = "POST"
  type                    = "AWS"
  uri                     = "arn:aws:apigateway:${var.region}:dynamodb:action/Scan"

  request_templates = {
    "application/json" = jsonencode({
      TableName = "inventory-env"
    })
  }
}

resource "aws_api_gateway_deployment" "inventory_deployment" {
  depends_on = [
    aws_api_gateway_integration.inventory_integration
  ]

  rest_api_id = aws_api_gateway_rest_api.inventory_api.id
  stage_name  = "dev"
}
```

### Testing

1. **Use a tool like Postman or curl to test the API**:
   - Send a GET request to the API.
   - Verify that the API returns all items from the DynamoDB table.

By following these steps, you will have set up an API Gateway integrated with DynamoDB that fetches all items from the table without requiring any input parameters. Adjust the steps as needed for your specific use case and environment.
