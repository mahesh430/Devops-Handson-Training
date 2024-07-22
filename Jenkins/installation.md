#!/bin/bash
# Update the system
yum update -y

# Install Java (Amazon Corretto 17)
amazon-linux-extras install java-openjdk17 -y

# Install Git
yum install git -y

# Install Maven
yum install maven -y

# Install Docker
amazon-linux-extras install docker -y
service docker start
usermod -a -G docker ec2-user

# Install Jenkins
wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins.io/redhat-stable/jenkins.repo
rpm --import http://pkg.jenkins.io/redhat-stable/jenkins.io.key
yum install jenkins -y

# Start Jenkins service
systemctl start jenkins
systemctl enable jenkins

# Ensure Jenkins and Docker services start on boot
chkconfig jenkins on
chkconfig docker on

# Open necessary ports in the firewall
# Allowing traffic on port 8080 (Jenkins) and port 22 (SSH)
iptables -I INPUT -p tcp --dport 8080 -j ACCEPT
iptables -I INPUT -p tcp --dport 22 -j ACCEPT
service iptables save

# Add Jenkins user to Docker group
usermod -a -G docker jenkins

# Print initial Jenkins admin password
echo "Initial Jenkins Admin Password: $(cat /var/lib/jenkins/secrets/initialAdminPassword)"

# Reboot the instance to ensure all changes take effect
reboot
