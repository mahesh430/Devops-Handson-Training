To configure a Jenkins Git webhook, follow these steps:

### Prerequisites:
1. Jenkins installed and running.
2. Git repository (e.g., GitHub, GitLab, Bitbucket).
3. Jenkins job (pipeline or freestyle) set up.

### Steps:

#### 1. Configure Jenkins:
1. **Install Git Plugin:**
   - Go to Jenkins Dashboard.
   - Click on `Manage Jenkins` > `Manage Plugins`.
   - Under the `Available` tab, search for `Git Plugin`.
   - Install it (if not already installed) and restart Jenkins if required.

2. **Install GitHub Integration Plugin (if using GitHub):**
   - Go to `Manage Jenkins` > `Manage Plugins`.
   - Under the `Available` tab, search for `GitHub Integration Plugin`.
   - Install it and restart Jenkins if required.

#### 2. Set Up Jenkins Job:
1. **Create a New Job:**
   - Go to Jenkins Dashboard.
   - Click on `New Item`.
   - Enter a name for your job and select `Freestyle project` or `Pipeline`, then click `OK`.

2. **Configure Source Code Management:**
   - In the job configuration page, under the `Source Code Management` section, select `Git`.
   - Enter your repository URL.
   - Provide credentials if required.

3. **Add Build Trigger:**
   - Under the `Build Triggers` section, check the `GitHub hook trigger for GITScm polling` or `Build when a change is pushed to GitLab` (depending on your Git provider).

4. **Add Build Steps:**
   - Add the build steps relevant to your project (e.g., Execute shell, Invoke Gradle script, etc.).

5. **Save the Job Configuration:**
   - Click on `Save`.

#### 3. Configure Webhook in Git Repository:
1. **GitHub:**
   - Go to your repository on GitHub.
   - Navigate to `Settings` > `Webhooks`.
   - Click on `Add webhook`.
   - In the `Payload URL` field, enter `http://<your-jenkins-server>/github-webhook/` (replace `<your-jenkins-server>` with your actual Jenkins server URL).
   - Set the `Content type` to `application/json`.
   - Leave the `Secret` field empty (unless you want to set a secret token).
   - Select `Let me select individual events` and choose `Push events` (or `Just the push event`).
   - Click on `Add webhook`.

2. **GitLab:**
   - Go to your project on GitLab.
   - Navigate to `Settings` > `Webhooks`.
   - In the `URL` field, enter `http://<your-jenkins-server>/gitlab/notify_commit` (replace `<your-jenkins-server>` with your actual Jenkins server URL).
   - Set the `Secret Token` if required.
   - Select `Push events`.
   - Click on `Add webhook`.

3. **Bitbucket:**
   - Go to your repository on Bitbucket.
   - Navigate to `Settings` > `Webhooks`.
   - Click on `Add webhook`.
   - In the `URL` field, enter `http://<your-jenkins-server>/bitbucket-hook/` (replace `<your-jenkins-server>` with your actual Jenkins server URL).
   - Set the `Trigger` to `Repository push`.
   - Click on `Save`.

#### 4. Test the Webhook:
1. **Push a Change:**
   - Make a change in your repository and push it to the remote repository.

2. **Verify Jenkins Job:**
   - Go to Jenkins Dashboard.
   - Check if the job is triggered automatically.
   - Verify the build logs and ensure the job runs successfully.

By following these steps, you should be able to configure a Jenkins Git webhook to trigger builds automatically upon changes in your repository.
