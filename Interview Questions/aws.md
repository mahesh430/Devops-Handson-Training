### 1. How would you set up a highly available web application in AWS using EC2, ELB, and Auto Scaling?

**Answer:** A high-level overview of the steps to set up a highly available web application in AWS using EC2, ELB, and Auto Scaling:
- Launch multiple EC2 instances in multiple Availability Zones (AZs) to provide high availability.
- Create an Elastic Load Balancer (ELB) to distribute incoming traffic evenly across all EC2 instances in different AZs.
- Set up Auto Scaling for the EC2 instances to automatically add or remove instances based on demand and maintain the desired number of instances.
- Use Amazon RDS or Amazon DynamoDB for database services to ensure that the database layer is highly available and scalable.
- Store your application data in Amazon S3 or use Amazon EBS volumes with multiple AZs to ensure data durability.
- Set up Amazon Route 53 for routing traffic to the ELB.
- Use Amazon CloudWatch to monitor the performance of the EC2 instances, ELB, and the overall system, and set up alarms to automatically trigger scaling events based on specified thresholds.
- Use Amazon SNS to receive notifications about the state of your EC2 instances, ELB, and Auto Scaling.
- Finally, configure security groups for EC2 instances and ELB to allow only required incoming and outgoing traffic.

### 2. Can you explain the steps to configure a VPC with public and private subnets, including network access control and security group rules?

**Answer:** Here’s a high-level overview of the steps to configure a VPC with public and private subnets, including network access control and security group rules:
- After creating VPC, create public and private subnets in different Availability Zones (AZs) within the VPC. Set up an Internet Gateway and attach it to the VPC.
- Configure a route table for the public subnets, with a route to the Internet Gateway for internet access.
- Configure a separate route table for the private subnets, with no direct route to the Internet Gateway.
- Create Network Access Control Lists (NACLs) to define inbound and outbound traffic rules for the public and private subnets.
- Create security groups for instances in the public subnets, with rules to allow incoming traffic for HTTP, HTTPS, and other required ports.
- Create security groups for instances in the private subnets, with rules to allow only necessary incoming and outgoing traffic, such as traffic from the public subnets or other trusted sources.
- Launch EC2 instances in the public and private subnets and associate them with the appropriate security groups.
- Optionally, set up a NAT Gateway in the public subnet to allow instances in the private subnet to access the internet for updates or other needs.

### 3. How would you implement a disaster recovery solution in AWS using RDS, EC2, and S3?

**Answer:**
- Create an Amazon RDS instance in a primary region, and configure automatic backups to Amazon S3.
- Create an Amazon EC2 instance in the same primary region.
- Create an Amazon S3 bucket to store data backups, and configure the RDS instance to store backups in the S3 bucket.
- Set up an Amazon EC2 instance in a secondary region and install the necessary software to access the S3 bucket.
- Create an Amazon RDS instance in the secondary region and configure it as a replica of the primary RDS instance.
- Configure the secondary RDS instance to automatically fail over to the primary RDS instance in case of a disaster in the secondary region.
- Regularly test the failover process to ensure it is working as expected.
- Use Amazon S3 versioning and object lifecycle management policies to retain backups for a desired period of time.
- Use Amazon CloudWatch to monitor the RDS instances and EC2 instances, and set up alarms to trigger notifications or automated actions in case of a disaster.

### 4. How would you use AWS CloudTrail and CloudWatch to monitor and log AWS resource activity and events?

**Answer:** AWS CloudTrail and CloudWatch are two services that can be used to monitor and log AWS resource activity and events. CloudTrail records API calls made to AWS services and stores information about the caller, time of call, source IP address, request parameters, and response elements. This information can be used to track changes to AWS resources and identify security threats. CloudTrail trails can be created to specify the AWS resources for which API calls should be recorded and logs can be sent to CloudWatch Logs for central storage and analysis.

### 5. How do you identify which is a private subnet and public subnet?

**Answer:** A public subnet has a route to an Internet Gateway (IGW) allowing direct internet access, whereas a private subnet does not have a route to an IGW and typically routes outbound traffic through a NAT Gateway in a public subnet for internet access.

### 6. What are VPC endpoints, how many are there, and what are the benefits of using them?

**Answer:** VPC endpoints are used to privately connect your VPC to supported AWS services and VPC endpoint services. There are two types of VPC endpoints: Interface endpoints and Gateway endpoints. Benefits include enhanced security by keeping traffic within the AWS network and reducing costs by avoiding data transfer through public internet.

### 7. If I want to increase the size of an EC2 instance, how can I do it?

**Answer:** You can increase the size of an EC2 instance by stopping the instance, changing the instance type to a larger instance type from the EC2 console or using the AWS CLI, and then restarting the instance.

### 8. What is an API Gateway and how many types of API endpoints are there?

**Answer:** AWS API Gateway is a fully managed service for creating, publishing, maintaining, monitoring, and securing APIs. Types of API endpoints include Regional endpoints, Edge-optimized endpoints, and Private endpoints.

### 9. How do you integrate DynamoDB or Lambda with API Gateway?

**Answer:** To integrate DynamoDB with API Gateway, you can create a mapping template to transform API requests into DynamoDB API requests. To integrate Lambda, you create a Lambda function and set up an API Gateway endpoint that triggers the Lambda function.

### 10. What is CloudFront, and what are the origins?

**Answer:** AWS CloudFront is a content delivery network (CDN) service that securely delivers data, videos, applications, and APIs globally with low latency. Origins are the source locations where CloudFront retrieves the content, such as an S3 bucket, an HTTP server, or an ELB.

### 11. Difference between application and network load balancer? Which one should I use for which use case?

**Answer:** An Application Load Balancer (ALB) operates at the application layer (Layer 7) and is best for HTTP/HTTPS traffic and advanced request routing. A Network Load Balancer (NLB) operates at the transport layer (Layer 4) and is best for handling high throughput and low latency TCP/UDP traffic. Use ALB for web applications and microservices, and NLB for high-performance network traffic.

### 12. What is a transit gateway and what are the advantages of using it?

**Answer:** A Transit Gateway allows you to connect multiple VPCs and on-premises networks through a single gateway. Advantages include simplified network architecture, centralized management, and scalable connections.

### 13. What is the difference between private and public hosted zones in AWS Route 53?

**Answer:** A public hosted zone manages DNS records for a domain accessible from the internet, while a private hosted zone manages DNS records for a domain accessible only within one or more VPCs.

### 14. An EC2 instance in account A wants to communicate with account B, how can this be possible and explain the process?

**Answer:** To enable communication between EC2 instances in different AWS accounts, you can set up VPC peering between the VPCs in account A and account B. Configure the security groups and route tables to allow traffic between the instances.

### 15. What is versioning and replication in S3 and what are the benefits of using them?

**Answer:** Versioning in S3 allows you to keep multiple versions of an object, which helps in recovering from accidental deletions and overwrites. Replication enables automatic copying of objects across different S3 buckets, useful for cross-region replication for disaster recovery and compliance.

### 16. What are resource policies and how are these different from IAM policies?

**Answer:** Resource policies are JSON documents that define permissions for resources, such as S3 buckets or SQS queues, and are attached directly to the resource. IAM policies are attached to IAM users, groups, or roles to grant permissions to AWS resources. Resource policies are specific to a resource, while IAM policies are user-centric.

### 17. What is the difference between NAT and internet gateway?

**Answer:** An Internet Gateway allows instances in public subnets to access the internet and vice versa. A NAT Gateway allows instances in private subnets to access the internet for updates while preventing the internet from initiating connections with those instances.

### 18. What is VPC peering connection?

**Answer:** VPC peering connection allows you to connect one VPC with another VPC. Instances in these VPCs behave as if they are in the same network.

### 19. What are NAT gateways?

**Answer:** NAT stands for Network Address Translation. NAT gateways enable instances in a private subnet to connect to the internet but prevent the internet from initiating a connection with those instances.

### 20. How can you control the security to your VPC?

**Answer:** You can use security groups and NACL (Network Access Control List) to control the security to your VPC.

### 21. What are the types of routing policies in Route 53?

**Answer:** Types of routing policies in Route 53:
- Simple routing
- Latency routing
- Failover routing
- Geolocation routing


- Weighted routing
- Multivalue answer

### 22. What is multi-AZ RDS?

**Answer:** Multi-AZ (Availability Zone) RDS allows you to have a replica of your production database in another availability zone. It is used for disaster recovery, ensuring high availability by automatically failing over to the standby database in case of a failure.

### 23. What is the difference between security groups and network access control list?

**Answer:** Security groups are stateful and operate at the instance level, controlling inbound and outbound traffic for associated instances. NACLs are stateless and operate at the subnet level, controlling inbound and outbound traffic at the subnet level.

### 24. What are the types of load balancers in EC2?

**Answer:** Types of load balancers in EC2:
- Application Load Balancer (ALB)
- Network Load Balancer (NLB)
- Classic Load Balancer (CLB)

### 25. What are the benefits of auto scaling?

**Answer:** Benefits of auto scaling:
- Better fault tolerance
- Better availability
- Better cost management

### 26. What are shared AMIs?

**Answer:** Shared AMIs are AMIs that are created by other developers and made available for others to use.

### 27. How can you convert a public subnet to private subnet?

**Answer:** Remove the Internet Gateway (IGW) and add a NAT Gateway, then associate the subnet with a private route table.

### 28. Is it possible to reduce an EBS volume?

**Answer:** No, it’s not possible to reduce an EBS volume size; you can only increase it.

### 29. What is the use of Elastic IP and are they charged by AWS?

**Answer:** Elastic IPs are static IPv4 addresses used to connect instances to the internet. They are charged if not associated with a running instance.

### 30. One of my S3 buckets is deleted but I need to restore it, is there any possible way?

**Answer:** If versioning is enabled, you can restore the bucket.

### 31. I need to modify the EBS volumes in Linux and Windows, is it possible?

**Answer:** Yes, it's possible. From the console, use the "Modify Volumes" option and specify the new size. For Windows, go to Disk Management; for Linux, mount it to achieve the modification.

### 32. After configuring ELB, you need to ensure that the user requests are always attached to a single instance. What setting can you use?

**Answer:** Sticky sessions (Session affinity).

### 33. What are the life cycle hooks used for AutoScaling?

**Answer:** They add an additional wait time to the scale-in or scale-out events, allowing you to perform custom actions before the instance is fully launched or terminated.fsecurity


