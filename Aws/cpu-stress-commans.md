
```markdown
# CPU Stress Test on Amazon Linux

This guide explains how to perform a CPU stress test on an Amazon Linux instance using the `stress` tool. Follow the steps below to install the required tools and run the stress test.

## Step 1: Enable EPEL Repository and Install `stress`

First, enable the EPEL repository and install the `stress` tool. Run the following commands:

```sh
sudo amazon-linux-extras install epel -y
sudo yum install stress -y
```

## Step 2: Perform the CPU Stress Test

To perform the CPU stress test, run the `stress` tool with one CPU stressor for 60 seconds. This will ensure the CPU usage exceeds 60%, effectively reaching close to 100% utilization during the test.

```sh
stress --cpu 1 --timeout 60s
```

## Monitoring CPU Usage

To monitor CPU usage in real-time, you can use the `top` or `htop` command in another terminal:

```sh
top
```

Or, if you have `htop` installed:

```sh
htop
```

These commands will allow you to see the CPU usage percentage in real-time.

## Summary

1. Enable EPEL repository and install `stress`:
   ```sh
   sudo amazon-linux-extras install epel -y
   sudo yum install stress -y
   ```

2. Run the stress test with one CPU stressor:
   ```sh
   stress --cpu 1 --timeout 60s
   ```

3. Monitor the CPU usage with `top` or `htop` to ensure it exceeds 60%.

By following these steps, you can effectively perform a CPU stress test on your Amazon Linux instance.
```
