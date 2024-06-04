---

# AWS VPC Peering and VPC Endpoints Documentation

## Table of Contents
1. [VPC Peering](#vpc-peering)
   - [Overview](#overview)
   - [Creating a VPC Peering Connection](#creating-a-vpc-peering-connection)
   - [Accepting a VPC Peering Connection](#accepting-a-vpc-peering-connection)
   - [Updating Route Tables](#updating-route-tables)
   - [Testing the Peering Connection](#testing-the-peering-connection)
2. [VPC Endpoints](#vpc-endpoints)
   - [Overview](#overview-1)
   - [Creating a VPC Endpoint for S3](#creating-a-vpc-endpoint-for-s3)
   - [Creating an Interface VPC Endpoint](#creating-an-interface-vpc-endpoint)
   - [Testing the VPC Endpoint](#testing-the-vpc-endpoint)

---

## VPC Peering

### Overview
VPC Peering enables you to route traffic between VPCs using private IP addresses, allowing instances in either VPC to communicate with each other as if they are within the same network.

### Creating a VPC Peering Connection

1. **Navigate to VPC Dashboard:**
   - Go to the AWS Management Console.
   - Navigate to **VPC**.

2. **Initiate a VPC Peering Connection:**
   - In the left-hand menu, click on **Peering Connections**.
   - Click on **Create Peering Connection**.
   - Enter the **Peering connection name tag**.
   - Select the **Requester VPC** and the **Accepter VPC**.
   - Click **Create Peering Connection**.

### Accepting a VPC Peering Connection

1. **Navigate to Peering Connections:**
   - Go to the AWS Management Console.
   - Navigate to **VPC**.

2. **Accept the Peering Connection:**
   - In the left-hand menu, click on **Peering Connections**.
   - Select the newly created peering connection.
   - Click on **Actions** > **Accept Request**.
   - Confirm the acceptance.

### Updating Route Tables

1. **Navigate to Route Tables:**
   - In the VPC dashboard, click on **Route Tables**.

2. **Update Route Table for Requester VPC:**
   - Select the route table associated with the **Requester VPC**.
   - Click on **Routes** > **Edit routes** > **Add route**.
   - Add a route for the CIDR block of the **Accepter VPC**.
   - Select the peering connection as the **Target**.
   - Click **Save routes**.

3. **Update Route Table for Accepter VPC:**
   - Repeat the steps for the route table associated with the **Accepter VPC**.

### Testing the Peering Connection

1. **Launch Instances:**
   - Launch instances in both VPCs.

2. **Test Connectivity:**
   - Use ping or SSH to test connectivity between the instances across the VPCs.

---

## VPC Endpoints

### Overview
VPC Endpoints allow you to privately connect your VPC to supported AWS services without needing an Internet Gateway, NAT device, VPN connection, or AWS Direct Connect.

### Creating a VPC Endpoint for S3

1. **Navigate to VPC Dashboard:**
   - Go to the AWS Management Console.
   - Navigate to **VPC**.

2. **Create Endpoint:**
   - In the left-hand menu, click on **Endpoints**.
   - Click on **Create Endpoint**.
   - Select the **Service name** for S3 (com.amazonaws.<region>.s3).
   - Select your **VPC**.
   - Select the **Route table** to be used by the endpoint.
   - Click **Create Endpoint**.

### Creating an Interface VPC Endpoint

1. **Navigate to VPC Dashboard:**
   - Go to the AWS Management Console.
   - Navigate to **VPC**.

2. **Create Interface Endpoint:**
   - In the left-hand menu, click on **Endpoints**.
   - Click on **Create Endpoint**.
   - Select the **Service name** for the AWS service you want to connect to.
   - Select your **VPC**.
   - Choose the **subnets** and **security groups** for the interface endpoint.
   - Click **Create Endpoint**.

### Testing the VPC Endpoint

1. **Launch an Instance in the VPC:**
   - Launch an instance in the VPC where the endpoint is created.

2. **Access the Service:**
   - Use the private IP address to access the AWS service. For example, access an S3 bucket using the private IP.

---

### Useful Links:
- [VPC Peering Documentation](https://docs.aws.amazon.com/vpc/latest/peering/what-is-vpc-peering.html)
- [VPC Endpoints Documentation](https://docs.aws.amazon.com/vpc/latest/userguide/vpc-endpoints.html)
