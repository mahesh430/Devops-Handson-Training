
# Lab Session: Linux System Administration

## Introduction
This lab session is designed to teach participants how to manage software packages and services on Linux systems using the `yum` package manager and the `systemctl` command for service management. By the end of this session, participants will be familiar with installing, updating, and removing software packages, as well as starting, stopping, and configuring system services.

## Objectives
- Install and remove software packages using `yum`.
- Manage system services using `systemctl`.
- Configure services to start on boot.

## Prerequisites
- Access to a CentOS, RHEL, or Amazon Linux 2 instance.
- Sudo or root access on the system.

## Exercises

### Exercise 1: Installing Web Server (Apache HTTPD)
1. **Install Apache HTTP Server**:
   ```bash
   sudo yum install -y httpd
   ```
2. **Start the Apache Service**:
   ```bash
   sudo systemctl start httpd
   ```
3. **Enable Apache to Start at Boot**:
   ```bash
   sudo systemctl enable httpd
   ```
4. **Verify Installation**:
   - Check that Apache is running by visiting `http://<Your-Server-IP>` or run:
     ```bash
     sudo systemctl status httpd
     ```

### Exercise 2: Installing and Configuring a Database Server (MariaDB)
1. **Install MariaDB**:
   ```bash
   sudo yum install -y mariadb-server
   ```
2. **Start the MariaDB Service**:
   ```bash
   sudo systemctl start mariadb
   ```
3. **Secure MariaDB Installation**:
   - Run the security script:
     ```bash
     sudo mysql_secure_installation
     ```
   - Follow the on-screen prompts to secure your database.

4. **Enable MariaDB to Start at Boot**:
   ```bash
   sudo systemctl enable mariadb
   ```

### Exercise 3: Installing and Managing NGINX
1. **Install NGINX**:
   ```bash
   sudo yum install -y nginx
   ```
2. **Start NGINX Service**:
   ```bash
   sudo systemctl start nginx
   ```
3. **Enable NGINX at Boot**:
   ```bash
   sudo systemctl enable nginx
   ```
4. **Verify NGINX is Running**:
   - You can check NGINX status by:
     ```bash
     sudo systemctl status nginx
     ```
   - Alternatively, access `http://<Your-Server-IP>` in a web browser.

### Exercise 4: Removing Software Packages
1. **Remove NGINX**:
   ```bash
   sudo yum remove -y nginx
   ```
2. **Check if NGINX is Removed**:
   ```bash
   rpm -q nginx
   ```

## Conclusion
This lab session provided a practical introduction to package and service management in Linux. Participants learned how to install, configure, and manage key system components crucial for web applications.

## Additional Resources
- [Yum Command Cheat Sheet](https://access.redhat.com/documentation/en-us/red_hat_enterprise_linux/7/html/system_administrators_guide/ch-yum)
- [Systemd Essentials](https://www.freedesktop.org/wiki/Software/systemd/)

---
