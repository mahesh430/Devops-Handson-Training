# Linux Essentials Lab Session

## Introduction

This lab session is designed to provide hands-on experience with key Linux commands used for monitoring system resources, managing processes, handling file compression, and transferring files. 

## Objectives

- Understand and use commands to manage and monitor system processes.
- Learn to compress, decompress, and transfer files.
- Gain insights into disk usage and memory management.

## Prerequisites

- Access to a Linux system (Ubuntu, CentOS, Debian, etc.).
- Basic knowledge of the Linux command line.

## Table of Contents

1. [System Monitoring](#system-monitoring)
   - [top](#top)
   - [htop](#htop)
   - [ps](#ps)
   - [free](#free)
   - [df](#df)
   - [du](#du)
2. [Process Management](#process-management)
   - [kill](#kill)
3. [File Management and Transfer](#file-management-and-transfer)
   - [scp](#scp)
   - [tar](#tar)
   - [gzip](#gzip)

## Lab Exercises

### System Monitoring

#### top
- **Description**: Displays real-time view of system processes.
- **Exercise**:
  ```bash
  top
  ```
  - Use `top` to view active processes. Press `q` to exit.

#### htop
- **Description**: An interactive process viewer, similar to `top` but more user-friendly.
- **Exercise**:
  ```bash
  htop
  ```
  - Install `htop` if not installed: `sudo yum install htop` (for centos/amazon linux).
  - Use `htop` to view processes. Use arrows to navigate; press `q` to exit.

#### ps
- **Description**: Reports a snapshot of current processes.
- **Exercise**:
  ```bash
  ps aux
  ```
  - Identify processes consuming the most resources.

#### free
- **Description**: Displays the total amount of free and used memory in the system.
- **Exercise**:
  ```bash
  free -h
  ```
  - Understand memory usage.

#### df
- **Description**: Reports file system disk space usage.
- **Exercise**:
  ```bash
  df -h
  ```
  - Check which file system is using the most disk space.

#### du
- **Description**: Estimates file space usage.
- **Exercise**:
  ```bash
  du -sh /path/of/directory
  ```
  - Measure the disk usage of a specific directory.

### Process Management

#### kill
- **Description**: Send a signal to a process, usually to stop the process.
- **Exercise**:
  ```bash
  ps aux | grep application_name
  kill -9 PID
  ```
  - Identify a process ID (PID) and terminate it using `kill -9`.

### File Management and Transfer

#### scp
- **Description**: Secure copy (SCP) is used to securely transfer files between hosts on a network.
- **Exercise**:
  ```bash
  scp /path/to/local/file username@remotehost:/path/to/remote/directory
  ```
  - Transfer a file to a remote server.

#### tar
- **Description**: Manages archives, combines multiple files into one.
- **Exercise**:
  ```bash
  tar -cvf archive_name.tar /path/to/directory
  tar -xvf archive_name.tar
  ```
  - Create an archive of a directory and then extract it.

#### gzip
- **Description**: Compresses files.
- **Exercise**:
  ```bash
  gzip filename
  gunzip filename.gz
  ```
  - Compress a file using `gzip` and then decompress it.

