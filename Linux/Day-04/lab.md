
# Linux File Permissions Lab

## Introduction
This lab focuses on understanding and managing file permissions and ownership in Linux. You will learn how to change file permissions using both symbolic and numeric (octal) notation and how to change file ownership.

## Objectives
- Understand Linux file permissions and ownership.
- Learn to use `chmod` to change file permissions.
- Learn to use `chown` to change file ownership.
- Practice using symbolic and numeric methods to set permissions.
- 
## Exercises

### Exercise 1: Viewing File Permissions and Ownership
1. **List Files with Detailed Information**
   - Use `ls -l` to list files in your current directory with detailed information including permissions and ownership.
   - Identify and note the permissions, owner, and group for each file.

### Exercise 2: Changing File Ownership
1. **Create a File**
   - Use `touch example.txt` to create a new file named `example.txt`.

2. **Change Ownership**
   - Use `sudo chown newowner example.txt` to change the owner of the file to `newowner`.
   - Use `sudo chown :newgroup example.txt` to change the group of the file to `newgroup`.
   - Verify the change using `ls -l`.

### Exercise 3: Using Symbolic Permissions
1. **Change Permissions Using Symbolic Method**
   - Use `chmod u=rwx,g=rx,o=r example.txt` to set the owner permissions to read, write, execute; group permissions to read, execute; and others to read.
   - Verify the changes with `ls -l`.

### Exercise 4: Using Numeric Permissions
1. **Change Permissions Using Numeric Method**
   - Use `chmod 754 example.txt` to set the permissions. Explain that `7` corresponds to read, write, execute for the owner; `5` to read, execute for the group; and `4` to read for others.
   - Verify the changes with `ls -l`.

### Exercise 5: Comprehensive Permission Management
1. **Set Complex Permissions**
   - Experiment with different combinations of permissions on `example.txt` or a new file using both symbolic and numeric methods.
   - Use `chmod o-w example.txt` to remove write permission from others.
   - Use `chmod 640 example.txt` to set read and write for owner, read for group, and no permissions for others.

## Conclusion
This lab helped you practice the fundamental commands for managing file permissions and ownership in Linux. Understanding these concepts is crucial for securing files and directories and for effective system administration.

## Additional Resources
- Linux man pages (use `man command_name` to explore more about commands like `chmod` and `chown`)
- Online Linux tutorials and forums

---
