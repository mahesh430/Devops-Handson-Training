## **For Windows:**

### **Step 1: Install Maven**

1. **Download Maven**:
   - Go to the [Maven download page](https://maven.apache.org/download.cgi).
   - Download the binary zip archive (e.g., `apache-maven-3.9.5-bin.zip`).

2. **Extract the Archive**:
   - Extract the downloaded zip file to a directory of your choice (e.g., `C:\Program Files\Apache\maven`).

3. **Set Environment Variables**:
   - Open the System Properties by right-clicking on `This PC` or `Computer` on your desktop or in File Explorer, then selecting `Properties`.
   - Click `Advanced system settings`.
   - Click `Environment Variables`.
   - In the `System variables` section, click `New` to add a new environment variable:
     - **Variable name**: `MAVEN_HOME`
     - **Variable value**: `C:\Program Files\Apache\maven`
   - Find the `Path` variable in the `System variables` section, select it, and click `Edit`.
   - Click `New` and add the path to the `bin` directory of your Maven installation:
     - `C:\Program Files\Apache\maven\bin`
   - Click `OK` to close all dialogs.

4. **Verify Maven Installation**:
   - Open Command Prompt and type:
     ```sh
     mvn -v
     ```
   - You should see the Maven version information if it is installed correctly.

## **For Mac:**

### **Step 1: Install Maven**

1. **Install Maven via Homebrew**:
   - Open Terminal and type:
     ```sh
     brew install maven
     ```

2. **Verify Maven Installation**:
   - In Terminal, type:
     ```sh
     mvn -v
     ```
   - You should see the Maven version information if it is installed correctly.

## **Configure Maven in Jenkins**

### **Step 1: Add Maven to Jenkins Global Tool Configuration**

1. **Open Jenkins**:
   - Open your web browser and navigate to your Jenkins instance, typically at `http://localhost:8080`.

2. **Install Maven Integration Plugin (if not already installed)**:
   - Go to `Manage Jenkins > Manage Plugins`.
   - Click on the `Available` tab.
   - Search for `Maven Integration` and install it if it's not already installed.

3. **Configure Maven in Jenkins**:
   - Go to `Manage Jenkins > Global Tool Configuration`.
   - Scroll down to the `Maven` section and click `Add Maven`.
   - Enter a name for the Maven installation (e.g., `Maven 3.9.5`).
   - Uncheck `Install automatically` since you have already installed Maven manually.
   - Specify the `MAVEN_HOME` as:
     - **Windows**: `C:\Program Files\Apache\maven`
     - **Mac**: `/usr/local/opt/maven/libexec` (or the path returned by `brew --prefix maven`)

### **Step 2: Verify Configuration in a Jenkins Job**

1. **Create a Jenkins Job**:
   - Create a new job in Jenkins (Freestyle Project).

2. **Configure the Job**:
   - In the job configuration, go to the `Build` section.
   - Add a `Build Step` and select `Invoke top-level Maven targets`.
   - Specify the goals (e.g., `clean install`).

3. **Run the Jenkins Job**:
   - Trigger the Jenkins job to build a Maven project.
   - Check the console output to ensure that Maven is being invoked correctly and the build is successfully
  






# If above steps not works try the below 

## **For Mac:**

### **Step 1: Verify Maven Installation**

1. **Check Maven Installation**:
   ```sh
   which mvn
   /usr/local/bin/mvn

   mvn -v
   ```

### **Step 2: Set Environment Variables in Jenkins**

#### **Option 1: Configure Global Environment Variables in Jenkins**

1. **Open Jenkins**:
   - Open your web browser and navigate to your Jenkins instance (e.g., `http://localhost:8080`).

2. **Manage Jenkins**:
   - Go to `Manage Jenkins > Configure System`.

3. **Set Global Environment Variables**:
   - Scroll down to the `Global properties` section.
   - Check the box `Environment variables`.
   - Add a new environment variable:
     - **Name**: `PATH`
     - **Value**: `/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin`
   - Ensure that the path to Maven (`/usr/local/bin`) is included in the value.

4. **Save** the configuration.

#### **Option 2: Configure Environment Variables for a Specific Job**

1. **Open Jenkins Job Configuration**:
   - Go to the specific job configuration where you're encountering the issue.

2. **Set Environment Variables for the Job**:
   - In the `Build Environment` section, check `Inject environment variables to the build process`.
   - Add an `Environment Variables` section.
   - Set the `PATH` environment variable to include the Maven path:
     ```
     PATH=/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin
     ```

3. **Save** the configuration.

### **Step 3: Verify Maven Configuration in Jenkins**

1. **Create or Update a Jenkins Job**:
   - Create a new job or update an existing one.

2. **Configure the Job**:
   - In the job configuration, go to the `Build` section.
   - Add a `Build Step` and select `Execute shell` (or `Invoke top-level Maven targets` for Maven-specific tasks).
   - For the shell step, you can add:
     ```sh
     mvn --version
     ```

3. **Run the Jenkins Job**:
   - Trigger the Jenkins job.
   - Check the console output to ensure that Maven is being invoked correctly.

### **Step 4: Restart Jenkins**

To ensure all changes take effect, restart Jenkins:
```sh
brew services restart jenkins-lts
```

## **For Windows:**

### **Step 1: Verify Maven Installation**

1. **Check Maven Installation**:
   ```sh
   which mvn
   C:\Program Files\Apache\maven\bin\mvn

   mvn -v
   ```

### **Step 2: Set Environment Variables in Jenkins**

#### **Option 1: Configure Global Environment Variables in Jenkins**

1. **Open Jenkins**:
   - Open your web browser and navigate to your Jenkins instance (e.g., `http://localhost:8080`).

2. **Manage Jenkins**:
   - Go to `Manage Jenkins > Configure System`.

3. **Set Global Environment Variables**:
   - Scroll down to the `Global properties` section.
   - Check the box `Environment variables`.
   - Add a new environment variable:
     - **Name**: `PATH`
     - **Value**: `C:\Program Files\Apache\maven\bin;C:\Windows\System32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\`
   - Ensure that the path to Maven (`C:\Program Files\Apache\maven\bin`) is included in the value.

4. **Save** the configuration.

#### **Option 2: Configure Environment Variables for a Specific Job**

1. **Open Jenkins Job Configuration**:
   - Go to the specific job configuration where you're encountering the issue.

2. **Set Environment Variables for the Job**:
   - In the `Build Environment` section, check `Inject environment variables to the build process`.
   - Add an `Environment Variables` section.
   - Set the `PATH` environment variable to include the Maven path:
     ```
     PATH=C:\Program Files\Apache\maven\bin;C:\Windows\System32;C:\Windows;C:\Windows\System32\Wbem;C:\Windows\System32\WindowsPowerShell\v1.0\
     ```

3. **Save** the configuration.

### **Step 3: Verify Maven Configuration in Jenkins**

1. **Create or Update a Jenkins Job**:
   - Create a new job or update an existing one.

2. **Configure the Job**:
   - In the job configuration, go to the `Build` section.
   - Add a `Build Step` and select `Execute Windows batch command` (or `Invoke top-level Maven targets` for Maven-specific tasks).
   - For the batch command step, you can add:
     ```sh
     mvn --version
     ```

3. **Run the Jenkins Job**:
   - Trigger the Jenkins job.
   - Check the console output to ensure that Maven is being invoked correctly.

### **Step 4: Restart Jenkins**

To ensure all changes take effect, restart Jenkins:
```sh
net stop jenkins
net start jenkins
```

By following these steps for both Mac and Windows, Jenkins should be able to locate and use Maven correctly.
