# Linux Users and Groups Lab

## Introduction
This lab session is designed to give you practical experience with managing users and groups on a Linux system. You'll learn how to create and delete users and groups, inspect system files relevant to user management, and perform operations related to file ownership and permissions.

## Exercises

### Exercise 1: Exploring Users and Groups
1. **Inspect User Information**
   - Use `cat /etc/passwd` to list the user accounts on your system.
   - Explain the fields in the output.

2. **Inspect Group Information**
   - Use `cat /etc/group` to list the groups on your system.
   - Discuss the significance of each field in the output.

### Exercise 2: Managing Users
1. **Create a New User**
   - Use `sudo useradd username` to create a new user with a home directory.
   - Set a password for the new user using `sudo passwd username`.

2. **Check User Information**
   - Use `id username` to display the user ID and group ID for the user.

3. **Delete a User**
   - Use `sudo userdel -r username` to delete the user and their home directory.

### Exercise 3: Managing Groups
1. **Create a New Group**
   - Use `sudo groupadd groupname` to create a new group.

2. **Add User to Group**
   - Use `sudo usermod -a -G groupname username` to add a user to the group.

3. **Delete a Group**
   - Use `sudo groupdel groupname` to delete a group.

### Exercise 4: File Ownership and Permissions
1. **Create a File and Assign Ownership**
   - Use `touch file.txt` and `sudo chown username:groupname file.txt` to change the file's owner and group.

2. **List Detailed File Information**
   - Use `ls -l file.txt` to view the permissions and ownership of the file.

### Exercise 5: Switching Users and Checking Identity
1. **Switch Users**
   - Use `su - username` to switch to another user account.
   - Use `whoami` to confirm the current user.
   - Exit back to the original user with `exit`.


---
