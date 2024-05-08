
# Linux Process Management Commands

This document provides a comprehensive guide to essential process management commands in Linux. These commands allow you to monitor, control, and manage system processes.

## Table of Contents

1. [top](#top)
2. [htop](#htop)
3. [ps](#ps)
4. [kill](#kill)
5. [pkill](#pkill)
6. [bg](#bg)
7. [fg](#fg)
8. [watch](#watch)

## Commands

### top

**Description:**  
`top` provides a dynamic real-time view of a running system. It displays a list of processes and their CPU usage.

**Usage:**  
```bash
top
```

**Key Bindings:**  
- Press `q` to quit.
- Press `h` for help.

### htop

**Description:**  
`htop` is an interactive process viewer and an enhanced version of `top`. It provides a more user-friendly and visually appealing overview of system processes, and allows for actions like process killing and nice level adjustments directly from its interface.

**Usage:**  
```bash
htop
```

**Installation (if not installed):**  
For Debian/Ubuntu:
```bash
sudo apt install htop
```
For Red Hat/CentOS:
```bash
sudo yum install htop
```

### ps

**Description:**  
`ps` displays information about active processes. It's a powerful tool with many options to customize output to fit various needs.

**Usage:**  
To see all active processes:
```bash
ps aux
```

### kill

**Description:**  
`kill` sends a signal to a process, typically to stop the process. By default, it sends SIGTERM (15).

**Usage:**  
To send SIGTERM to a process:
```bash
kill PID
```
To send SIGKILL (9) to forcefully stop a process:
```bash
kill -9 PID
```

### pkill

**Description:**  
`pkill` sends a signal to a process by name or other attributes, unlike `kill`, which uses process IDs.

**Usage:**  
To kill processes by name:
```bash
pkill process_name
```

### bg

**Description:**  
`bg` resumes suspended jobs in the background.

**Usage:**  
To continue the first suspended job in the background:
```bash
bg %1
```

### fg

**Description:**  
`fg` brings a job to the foreground.

**Usage:**  
To bring the first job to the foreground:
```bash
fg %1
```

### watch

**Description:**  
`watch` runs a command repeatedly, displaying its output and errors. This is useful for tracking changes, such as monitoring directory changes or the progress of a certain process.

**Usage:**  
To run `ls -lh` every 2 seconds:
```bash
watch -n 2 ls -lh
```

Certainly! Below is a GitHub documentation-style guide that outlines key commands for compressing and decompressing files in Linux. This guide includes examples of using commands like `tar`, `gzip`, `zip`, and `unzip`, and could be formatted for a repository's README file or wiki pages.

---

# Linux Compression and Decompression Commands

## Table of Contents

1. [gzip](#gzip)
2. [gunzip](#gunzip)
3. [tar](#tar)
4. [zip](#zip)
5. [unzip](#unzip)

## Commands

### gzip

**Description:**  
`gzip` reduces the size of the named files using Lempel-Ziv coding (LZ77). Whenever possible, each file is replaced by one with the extension `.gz`.

**Usage:**  
To compress a file:
```bash
gzip filename
```
To decompress a file:
```bash
gunzip filename.gz
```
or:
```bash
gzip -d filename.gz
```

### gunzip

**Description:**  
`gunzip` is essentially the same as `gzip -d`. It decompresses `.gz` files back to their original form.

**Usage:**  
```bash
gunzip filename.gz
```

### tar

**Description:**  
`tar` is a command-line utility used to store, archive, and extract files and directories into a single archive file known as a tarball. It is capable of creating `.tar` archives and handling other compression formats when combined with gzip, bzip2, etc.

**Usage:**  
To create a tar archive:
```bash
tar -cvf archive_name.tar directory_or_files
```
To extract from a tar archive:
```bash
tar -xvf archive_name.tar
```
To create a compressed tar.gz archive:
```bash
tar -czvf archive_name.tar.gz directory_or_files
```
To extract a tar.gz archive:
```bash
tar -xzvf archive_name.tar.gz
```

### zip

**Description:**  
`zip` is a command to package and compress (archive) files. Files can be added to a zip file and optionally compressed.

**Usage:**  
To create a zip archive:
```bash
zip archive_name.zip files_or_directories
```
To add files to existing zip file:
```bash
zip -ur archive_name.zip new_files
```

### unzip

**Description:**  
`unzip` extracts and lists compressed files in a ZIP archive.

**Usage:**  
To extract a zip file:
```bash
unzip archive_name.zip
```
To list zip file contents:
```bash
unzip -l archive_name.zip
```
