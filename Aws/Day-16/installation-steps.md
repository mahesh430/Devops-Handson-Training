Here's a step-by-step guide to install AWS CLI and configure secret and access keys on both Windows and Mac. This guide is designed to be suitable for inclusion in a GitHub repository's documentation.

### AWS CLI Installation and Configuration Guide

This guide provides instructions on how to install the AWS Command Line Interface (CLI) and configure it with your AWS credentials on both Windows and Mac.

#### Table of Contents
- [Windows Installation](#windows-installation)
  - [Step 1: Install AWS CLI](#step-1-install-aws-cli-on-windows)
  - [Step 2: Configure AWS CLI](#step-2-configure-aws-cli-on-windows)
- [Mac Installation](#mac-installation)
  - [Step 1: Install AWS CLI](#step-1-install-aws-cli-on-mac)
  - [Step 2: Configure AWS CLI](#step-2-configure-aws-cli-on-mac)

## Windows Installation

### Step 1: Install AWS CLI on Windows

1. **Download the AWS CLI MSI installer** from the [official AWS CLI page](https://aws.amazon.com/cli/).

2. **Run the downloaded MSI installer** and follow the instructions to complete the installation.

3. **Verify the installation** by opening a Command Prompt and running:

   ```sh
   aws --version
   ```

   You should see the version information of AWS CLI if it is installed correctly.

### Step 2: Configure AWS CLI on Windows

1. **Open a Command Prompt**.

2. **Run the `aws configure` command** to set up your AWS credentials and default region:

   ```sh
   aws configure
   ```

3. **Enter the following information when prompted**:
   - AWS Access Key ID: `your-access-key-id`
   - AWS Secret Access Key: `your-secret-access-key`
   - Default region name: `your-default-region` (e.g., `us-west-2`)
   - Default output format: `json` (or your preferred format)

## Mac Installation

### Step 1: Install AWS CLI on Mac

1. **Install the AWS CLI using Homebrew**. If you don't have Homebrew installed, first install Homebrew by running the following command in your terminal:

   ```sh
   /bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"
   ```

2. **Install AWS CLI** by running:

   ```sh
   brew install awscli
   ```

3. **Verify the installation** by running:

   ```sh
   aws --version
   ```

   You should see the version information of AWS CLI if it is installed correctly.

### Step 2: Configure AWS CLI on Mac

1. **Open a Terminal**.

2. **Run the `aws configure` command** to set up your AWS credentials and default region:

   ```sh
   aws configure
   ```

3. **Enter the following information when prompted**:
   - AWS Access Key ID: `your-access-key-id`
   - AWS Secret Access Key: `your-secret-access-key`
   - Default region name: `your-default-region` (e.g., `us-west-2`)
   - Default output format: `json` (or your preferred format)

### Additional Information

For more detailed information, please refer to the [AWS CLI User Guide](https://docs.aws.amazon.com/cli/latest/userguide/cli-configure-quickstart.html).

This completes the installation and configuration of AWS CLI on both Windows and Mac. If you encounter any issues, please consult the AWS CLI documentation or reach out to your administrator for assistance.

---

