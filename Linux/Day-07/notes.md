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
