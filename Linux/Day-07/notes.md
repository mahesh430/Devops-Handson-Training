# Linux Networking Commands Documentation

## Table of Contents
1. [Introduction](#introduction)
2. [Networking Commands](#networking-commands)
   - [ifconfig](#ifconfig)
   - [ip](#ip)
   - [netstat](#netstat)
   - [curl](#curl)
   - [route](#route)
   - [ping](#ping)
   - [tracepath](#tracepath)
   - [hostname](#hostname)
   - [dig](#dig)
   - [nslookup](#nslookup)
   - [telnet](#telnet)
   - [Additional Commands](#additional-commands)

## Introduction
This document provides an overview and practical usage examples of common Linux networking commands. These commands are essential tools for system administrators and network engineers for troubleshooting and managing network-related tasks in a Linux environment.

## Networking Commands

### ifconfig
**Description**: `ifconfig` is used to configure, control, and query TCP/IP network interface parameters.

**Example**:
```bash
ifconfig eth0
```

### ip
**Description**: Modern replacement for `ifconfig`, used to show and manipulate routing, network devices, interfaces, and tunnels.

**Example**:
```bash
ip addr show
```

### netstat
**Description**: Displays network connections, routing tables, interface statistics, and more.

**Example**:
```bash
netstat -tuln
```

### curl
**Description**: Tool to transfer data from or to a server.

**Example**:
```bash
curl https://www.example.com
```

### route
**Description**: Shows/manipulates the IP routing table.

**Example**:
```bash
route -n
```

### ping
**Description**: Tests the reachability of a host on an IP network.

**Example**:
```bash
ping -c 4 google.com
```

### tracepath
**Description**: Traces path packets take to a network host.

**Example**:
```bash
tracepath google.com
```

### hostname
**Description**: Shows or sets the system's host name.

**Example**:
```bash
hostname
```

### dig
**Description**: DNS lookup utility.

**Example**:
```bash
dig google.com
```

### nslookup
**Description**: Queries Internet domain name servers.

**Example**:
```bash
nslookup google.com
```

### telnet
**Description**: Performs interactive communication with another host.

**Example**:
```bash
telnet example.com 80
```

### Additional Commands
- **ss**: Investigates sockets.
- **mtr**: Network diagnostic tool.
- **wget**: Retrieves files from the web.
- **arp**: Manipulates or displays the ARP cache.

## Conclusion
This guide provides a foundation for using various Linux networking commands to manage and troubleshoot network-related tasks. Proper understanding and usage of these commands can significantly aid in network administration.

---
