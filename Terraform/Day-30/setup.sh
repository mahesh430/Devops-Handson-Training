#!/bin/bash

# Update the package repository
sudo yum update -y

# Install Nginx
sudo amazon-linux-extras install nginx1.12 -y

# Start Nginx service
sudo systemctl start nginx

# Enable Nginx to start on boot
sudo systemctl enable nginx

# Create a simple HTML page
echo "<html><body><h1>Hello from Nginx on Amazon Linux</h1></body></html>" | sudo tee /usr/share/nginx/html/index.html

# Adjust firewall rules to allow HTTP and HTTPS traffic
sudo firewall-cmd --zone=public --permanent --add-service=http
sudo firewall-cmd --zone=public --permanent --add-service=https
sudo firewall-cmd --reload

# Print the Nginx status
sudo systemctl status nginx
