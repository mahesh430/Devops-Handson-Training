## Linux Networking Commands

### 1. **ifconfig**
- **Description**: Configures, controls, and queries network interface parameters.
- **Common Flags**:
  - `-a`: Displays all interfaces, even if down.
  - `-s`: Displays a short list.
- **Example**:
  ```bash
  ifconfig eth0
  ```

### 2. **ip**
- **Description**: A versatile tool for network interface, routing, and tunnel configuration.
- **Subcommands**:
  - `addr`: Manage IP addresses.
  - `route`: Manage routing tables.
- **Example**:
  ```bash
  ip addr show
  ip route list
  ```

### 3. **netstat**
- **Description**: Shows network connections, routing tables, and interface statistics.
- **Common Flags**:
  - `-t`: Show TCP connections.
  - `-u`: Show UDP connections.
  - `-l`: Show only listening sockets.
  - `-n`: Show numerical addresses instead of resolving names.
- **Example**:
  ```bash
  netstat -tuln
  ```

### 4. **curl**
- **Description**: A tool to transfer data from or to a server.
- **Common Flags**:
  - `-O`: Save file with its original name.
  - `-o`: Save output to a file named as specified.
  - `-I`: Fetch the HTTP-header only.
- **Example**:
  ```bash
  curl -O https://example.com/file.tar.gz
  ```

### 5. **route**
- **Description**: Show or manipulate the IP routing table.
- **Common Flags**:
  - `-n`: Show numerical addresses instead of trying to determine symbolic host names.
- **Example**:
  ```bash
  route -n
  ```

### 6. **ping**
- **Description**: Checks connectivity between the host and a target node.
- **Common Flags**:
  - `-c`: Number of echo requests to send.
  - `-i`: Interval between successive packet sends.
- **Example**:
  ```bash
  ping -c 4 google.com
  ```

### 7. **tracepath**
- **Description**: Traces path to a network host discovering MTU along this path.
- **Example**:
  ```bash
  tracepath google.com
  ```

### 8. **hostname**
- **Description**: Shows or sets the system’s host name.
- **Example**:
  ```bash
  hostname
  ```

### 9. **dig**
- **Description**: DNS lookup utility.
- **Common Flags**:
  - `+short`: Gives just the answer to a query.
  - `+trace`: Traces the path of the query to the DNS root.
- **Example**:
  ```bash
  dig google.com +short
  ```

### 10. **nslookup**
- **Description**: Queries Internet domain name servers.
- **Common Options**:
  - `-type=any`: Queries DNS for records of any type.
- **Example**:
  ```bash
  nslookup -type=mx google.com
  ```

### 11. **telnet**
- **Description**: Interacts with another host using the TELNET protocol.
- **Example**:
  ```bash
  telnet example.com 80
  ```

### Additional Commands

- **ss**: Utility to investigate sockets.
  - `-t`: Display TCP sockets.
  - `-u`: Display UDP sockets.
  - `-l`: Show listening sockets.
  - `-n`: Do not resolve names.
  ```bash
  ss -tuln
  ```
  
- **mtr**: Combines the functionality of `traceroute` and `ping`.
  - `--report`: Generates a summary report of the connection route.
  ```bash
  mtr --report google.com
  ```

- **wget**: Non-interactive network downloader.
  - `-c`: Continue getting a partially-downloaded file.
  - `-r`: Recursive download.
  ```bash
  wget -c https://example.com/file.tar.gz
  ```

- **arp**: Manipulate or display the ARP cache.
  - `-a`: Display all ARP entries.
  ```bash
  arp -a
  ```

---

# Understanding the `/etc/hosts` and `resolv.conf` Files in Linux

## Overview
The `/etc/hosts` and `resolv.conf` files play crucial roles in the network configuration of a Linux system. They control how the system resolves hostnames to IP addresses.

## `/etc/hosts`

### Description
The `/etc/hosts` file is an operating system file that maps hostnames to IP addresses. It is one of several methods used by a system to resolve domain names. In many cases, it can be used to override DNS lookups.

### Format
Each line in the file contains an IP address followed by one or more hostnames. Entries are typically separated by whitespace (spaces or tabs). Here is an example of its content:

```
127.0.0.1   localhost
192.168.1.10   example.local example
```

- `127.0.0.1` is the loopback IP address typically assigned to `localhost`.
- `192.168.1.10` could be an IP address for a local computer or server within your network.

### Common Uses
- **Local DNS**: It's often used in development environments to point to locally hosted domains without modifying DNS servers.
- **Network Testing**: Useful for testing by redirecting domain names to specified IPs.
- **Blocking**: To block websites by pointing the domain name to a non-routable IP.

## `resolv.conf`

### Description
The `resolv.conf` file is used to configure DNS servers for a Linux machine. It specifies details about DNS name resolution and how DNS queries should be resolved.

### Format
This file typically contains entries that specify DNS servers and options for the DNS resolver. Here is a typical example:

```
nameserver 8.8.8.8
nameserver 8.8.4.4
search localdomain
```

- `nameserver`: Specifies the IP addresses of DNS servers.
- `search`: Used to define the domain search list.

### Common Uses
- **DNS Configuration**: Primary use is to point to the right DNS servers.
- **Search Domains**: Simplifies querying within local networks.
- **Options**: Can include options like `timeout`, `attempts`, `ndots` that control the behavior of the resolver.

## Editing Guidelines

### `/etc/hosts`
1. Open the file with a text editor with root privileges:
   ```bash
   sudo nano /etc/hosts
   ```
2. Make your changes carefully.
3. Save the file and exit. Changes are applied immediately.

### `resolv.conf`
1. Open the file with a text editor with root privileges:
   ```bash
   sudo nano /resolv.conf
   ```
2. Add or modify the nameserver lines as required.
3. Save and exit. Some systems manage this file automatically (like those using `systemd-resolved`), so manual changes might be overwritten.

