### Re-Attaching the EBS Volume to Another Instance

This section outlines the complete steps for attaching the previously used EBS volume to a new Linux EC2 instance and verifying that the data persists.

#### Step 1: Attach the Volume to a New Instance
- **Navigate to the EC2 Dashboard** within the AWS Management Console.
- Go to **Volumes** under **Elastic Block Store**.
- Locate the EBS volume that was previously detached. You can identify it by its ID or the tags you assigned earlier.
- Right-click on the volume and select **Attach Volume**.
- Select the new instance to which you want to attach the volume. Ensure that this instance is in the same availability zone as the volume.
- Assign a device identifier (e.g., `/dev/sdf`). AWS might suggest a device name; make sure it's compatible with your instance's operating system.
- Click **Attach** to connect the volume to the new instance.

#### Step 2: Connect to the New Instance
- Use SSH to connect to the new instance. Replace `instance-ip-address` with the actual IP address of the instance:
  ```bash
  ssh -i /path/to/your/key.pem ec2-user@instance-ip-address
  ```

#### Step 3: Mount the Volume
Before attempting to mount the volume, verify that it is recognized by the system:
- **List the available disks**:
  ```bash
  lsblk
  ```
  Look for the disk identifier that matches the one you assigned (e.g., `xvdf`), and verify it does not yet have a mount point.

- **Create a mount point** if it doesn’t exist:
  ```bash
  sudo mkdir /data
  ```
- **Formate the volume** if the volume is not formated, format it using the file system such as ext4
 ```bash
  sudo mkfs -t ext4 /dev/xvdf
  ```
- **Mount the disk** to the new directory:
  ```bash
  sudo mount /dev/xvdf /data
  ```
  This command mounts the volume to `/data` on the new instance.

#### Step 4: Verify the Data
Ensure that the data created on the volume from the previous instance is visible and intact:
- **List the contents of the mounted directory**:
  ```bash
  ls /data
  ```
  This should display `file1.txt` and `new_directory`.

- **Check the contents of the new directory**:
  ```bash
  ls /data/new_directory
  ```
  This should display `file2.txt`.

#### Step 5: Confirm Everything is Working
- **Verify read/write operations** by creating a new file:
  ```bash
  sudo touch /data/test_file.txt
  ls /data
  ```
  This tests that the volume is not only mounted correctly but is also writable.
