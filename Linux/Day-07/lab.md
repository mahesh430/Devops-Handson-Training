# Linux Networking Commands Lab Session

## Introduction

This lab session is designed to provide hands-on experience with common Linux networking commands. Participants will learn how to inspect and manipulate network configurations and perform basic network diagnostics.

## Objectives

- Understand and use various network commands.
- Configure and query network interfaces.
- Perform network diagnostics and resolve DNS queries.
## Lab Exercises

### Exercise 1: Managing Network Interfaces

#### ifconfig
1. **List all interfaces:**
   ```bash
   ifconfig
   ```

2. **View a specific interface configuration (e.g., `eth0`):**
   ```bash
   ifconfig eth0
   ```

#### ip
3. **List IP addresses for all interfaces:**
   ```bash
   ip addr show
   ```

4. **List the routing table:**
   ```bash
   ip route show
   ```

### Exercise 2: Testing Connectivity

#### ping
5. **Ping a remote server:**
   ```bash
   ping -c 4 google.com
   ```

#### traceroute
6. **Trace the route packets take to a network host:**
   ```bash
   traceroute google.com
   ```

### Exercise 3: Network Diagnostics

#### netstat
7. **Display all active connections:**
   ```bash
   netstat -ant
   ```

8. **Display listening ports:**
   ```bash
   netstat -an | grep LISTEN
   ```

#### dig
9. **Perform a DNS lookup:**
   ```bash
   dig google.com
   ```

#### nslookup
10. **Perform a DNS reverse lookup:**
    ```bash
    nslookup 8.8.8.8
    ```

### Exercise 4: Data Transfer

#### curl
11. **Download a webpage:**
    ```bash
    curl www.google.com
    ```

### Exercise 5: Manipulating /etc/hosts

12. **Edit the `/etc/hosts` file:**
    - Open the `/etc/hosts` file with a text editor (e.g., nano or vim):
      ```bash
      sudo nano /etc/hosts
      ```
    - Add a new entry:
      ```plaintext
      127.0.0.2   mytestsite.local
      ```
    - Save and exit the editor.
    - Test the new host:
      ```bash
      ping mytestsite.local
      ```

## Conclusion

By completing these exercises, participants will gain practical knowledge of handling network interfaces, diagnosing network issues, and configuring network-related files in Linux.

## Additional Resources

- [Linux man pages](http://man7.org/linux/man-pages/index.html) - Detailed command documentation
- [Cyberciti.biz](https://www.cyberciti.biz/) - Networking tutorials
