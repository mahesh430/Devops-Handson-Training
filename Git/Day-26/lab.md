Here is a comprehensive GitLab lab guide on creating a remote repository, cloning it, adding files, creating branches, and performing various Git operations like add, commit, push, pull, merging, and raising pull requests. This guide is formatted in GitHub documentation style.

### GitLab Lab Guide

## Table of Contents

1. [Introduction](#introduction)
2. [Prerequisites](#prerequisites)
3. [Creating a Remote Repository](#creating-a-remote-repository)
4. [Cloning the Repository](#cloning-the-repository)
5. [Adding Files](#adding-files)
6. [Creating a Branch](#creating-a-branch)
7. [Committing Changes](#committing-changes)
8. [Pushing Changes](#pushing-changes)
9. [Pulling Changes](#pulling-changes)
10. [Creating a Merge Request (Pull Request)](#creating-a-merge-request-pull-request)
11. [Approving and Merging a Merge Request](#approving-and-merging-a-merge-request)
12. [Conclusion](#conclusion)

---

## Introduction

This lab guide provides a step-by-step approach to using GitLab for common Git operations. You'll learn how to create a remote repository, clone it, manage branches, and perform commits, pushes, and merges.

## Prerequisites

- Git installed on your local machine. [Install Git](https://git-scm.com/book/en/v2/Getting-Started-Installing-Git)
- A GitLab account. [Sign up for GitLab](https://gitlab.com/users/sign_in)

## Creating a Remote Repository

1. Log in to your GitLab account.
2. Click the **New Project** button.
3. Select **Create blank project**.
4. Fill in the project details:
   - **Project name**: `my-gitlab-repo`
   - **Visibility Level**: Choose Public or Private
5. Click **Create project**.

## Cloning the Repository

1. Copy the repository URL from GitLab.
2. Open your terminal and run the following command:

```sh
git clone https://gitlab.com/your-username/my-gitlab-repo.git
cd my-gitlab-repo
```

## Adding Files

1. Create a new file in your repository directory:

```sh
echo "# My GitLab Repository" > README.md
```

2. Add the file to the staging area:

```sh
git add README.md
```

## Creating a Branch

1. Create a new branch:

```sh
git checkout -b feature-branch
```

## Committing Changes

1. Commit the staged changes:

```sh
git commit -m "Add README.md"
```

## Pushing Changes

1. Push the changes to the remote repository:

```sh
git push origin feature-branch
```

## Pulling Changes

1. Ensure you are on the main branch:

```sh
git checkout main
```

2. Pull the latest changes from the remote repository:

```sh
git pull origin main
```

## Creating a Merge Request (Pull Request)

1. Go to your project on GitLab.
2. Click on **Merge Requests** in the left sidebar.
3. Click **New merge request**.
4. Select the source branch (`feature-branch`) and the target branch (`main`).
5. Click **Compare branches and continue**.
6. Fill in the details and click **Create merge request**.

## Approving and Merging a Merge Request

1. Go to the **Merge Requests** section on GitLab.
2. Find your merge request and click on it.
3. Review the changes and comments.
4. Click **Merge** to merge the changes into the main branch.

## Conclusion

You've now completed the basic steps for creating a repository, managing branches, and performing Git operations using GitLab. This guide should help you understand the core workflows of Git and GitLab.

---
