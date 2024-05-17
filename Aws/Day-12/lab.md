Creating a VPC, subnets, route tables, internet and NAT gateways, and launching EC2 instances in both public and private subnets using the AWS Management Console is a practical task that will help you understand AWS networking fundamentals. Here's a detailed guide on how to perform these tasks manually via the AWS Console:

### AWS Networking Infrastructure Lab Setup

#### Objectives
- Create a VPC.
- Set up a public subnet and a private subnet.
- Configure an Internet Gateway (IG) and a NAT Gateway.
- Create route tables for public and private subnets.
- Launch EC2 instances in both subnets.
- Test connectivity by pinging instances.

### Step 1: Create a VPC
1. Go to the VPC Dashboard in the AWS Management Console.
2. Click "Create VPC".
3. Name your VPC and specify a CIDR block (e.g., `10.0.0.0/16`).
4. Leave the other options as defaults and click "Create".

### Step 2: Create Subnets
1. In the VPC Dashboard, click "Subnets" then "Create subnet".
2. Select your newly created VPC.
3. Create two subnets:
   - **Public Subnet**:
     - Name: PublicSubnet
     - CIDR: `10.0.1.0/24`
     - Availability Zone: Choose one (e.g., us-east-1a)
   - **Private Subnet**:
     - Name: PrivateSubnet
     - CIDR: `10.0.2.0/24`
     - Availability Zone: Choose the same as for the public subnet for simplicity.

### Step 3: Configure the Internet Gateway
1. Go to "Internet Gateways", click "Create internet gateway".
2. Name it (e.g., LabIGW), and create.
3. Attach it to your VPC by selecting the IG, clicking "Actions" and "Attach to VPC".

### Step 4: Set Up a NAT Gateway
1. Allocate an Elastic IP (EIP) by going to the EC2 Dashboard, under "Network & Security" choose "Elastic IPs", click "Allocate new address" and confirm.
2. Go to "NAT Gateways", click "Create NAT gateway".
3. Place it in the public subnet, select the allocated EIP, and link it to your VPC.
4. Click "Create a NAT Gateway".

### Step 5: Create Route Tables
1. Create a route table for your VPC in "Route Tables", click "Create route table".
   - Name it PublicRouteTable, associate it with your VPC.
2. Add a route to the public route table that directs internet-bound traffic to the internet gateway.
   - Destination: `0.0.0.0/0`
   - Target: Select your Internet Gateway.
3. Create another route table for the private subnet (PrivateRouteTable), add a route that directs internet-bound traffic to the NAT Gateway.
   - Destination: `0.0.0.0/0`
   - Target: Select your NAT Gateway.
4. Associate each route table with the respective subnet.

### Step 6: Launch EC2 Instances
1. Go to the EC2 Dashboard and click "Launch Instance".
2. Choose an AMI (Amazon Linux 2 AMI) and an instance type (e.g., t2.micro).
3. Configure instance details:
   - Network: Choose your VPC.
   - Subnet: Select your public subnet for the first instance.
   - Auto-assign Public IP: Enable (for public subnet only).
   - Repeat the process for the private subnet but disable Auto-assign Public IP.
4. Add storage, tags, and configure security groups as required.
5. Launch the instances using an existing key pair or create a new one.

### Step 7: Test Connectivity
1. SSH into the public instance (use its public IP).
2. From the public instance, attempt to SSH or ping the private instance using its private IP.

### Conclusion
This setup ensures you have a functioning AWS environment with basic network segmentation and routing. Ensure to delete resources you no longer need to avoid unnecessary charges.
