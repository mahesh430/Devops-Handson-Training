## Attaching an EBS Volume to a Linux EC2 Instance

### Step 1: Create an EBS Volume
- **Navigate to the EC2 Dashboard** in AWS Management Console.
- Go to **Volumes** under **Elastic Block Store**.
- Click **Create Volume**, select the desired volume type (e.g., General Purpose SSD), size, and ensure it is in the same availability zone as your instance.
- Click **Create**.

### Step 2: Attach the Volume to Your Instance
- Find the newly created volume under **Volumes**.
- Right-click on the volume and select **Attach Volume**.
- Select your instance by ID or name and assign a device identifier (e.g., `/dev/sdf`).
- Confirm by clicking **Attach**.

## Preparing and Using the Volume on Your Instance

### Step 1: Connect to Your Instance
- Use SSH to connect to your instance:
  ```bash
  ssh -i /path/to/your/key.pem ec2-user@instance-ip-address
  ```

### Step 2: Check and Prepare the New Disk
- **List the available disks** to confirm the new disk is attached:
  ```bash
  lsblk
  ```
- **Create a file system** on the new disk if it is not formatted:
  ```bash
  sudo mkfs -t xfs /dev/xvdf  # This formats the disk with the XFS file system.
  ```

### Step 3: Create a Mount Point and Mount the Volume
- **Create a directory** to mount the volume:
  ```bash
  sudo mkdir /data
  ```
- **Mount the disk** to the directory you created:
  ```bash
  sudo mount /dev/xvdf /data  # This mounts the volume to /data.
  ```

### Step 4: Create Files and Directories
- Navigate to the mounted directory and create files and directories:
  ```bash
  cd /data
  sudo touch file1.txt  # Creates a new file.
  sudo mkdir new_directory  # Creates a new directory.
  sudo touch new_directory/file2.txt  # Creates a new file inside the directory.
  ```

## Detaching the EBS Volume

### Step 1: Unmount the Volume
- Ensure all data is saved and close any processes using the disk.
- **Unmount the volume** to ensure data integrity:
  ```bash
  sudo umount /data  # Unmounts the volume.
  ```

### Step 2: Detach the Volume in AWS Console
- Go back to the **Volumes** section in the EC2 Dashboard.
- Select the volume, click **Actions**, and choose **Detach Volume**.
- Confirm the detachment.

## Re-Attaching the Volume to Another Instance

Repeat the attachment and mounting steps on a new instance to verify that the data persists across different instances.

### Step 1: Attach the Volume to a New Instance
- Follow the same steps as before to attach the volume to another Linux instance.

### Step 2: Mount and Verify the Volume
- Once attached, mount the volume as previously described.
- **Verify the files and directories**:
  ```bash
  ls /data  # Should list file1.txt and new_directory.
  ls /data/new_directory  # Should list file2.txt.
  ```

## Conclusion

By following these steps, you ensure the EBS volume is correctly managed and data persistence is verified across instance reattachments.
```

### Steps to Add to GitHub:
1. **Create or navigate to the `docs` directory in your repository**.
2. **Add the `EBS_Management_Linux.md` file** with the content provided above.
3. **Commit and push** the changes:
   ```bash
   git add docs/EBS_Management_Linux.md
   git commit -m "Add Linux EBS volume management documentation"
   git push
   ```

This document will provide your team with a clear and easily accessible guide for managing EBS volumes with Linux instances on AWS, directly from your GitHub repository.
