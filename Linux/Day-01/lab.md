## Getting Started

These labs can be performed on any Linux system. You will need access to a terminal. You can use a native Linux machine, a virtual machine, or a Docker container.

## Lab Exercises

### Exercise 1: Exploring Directories

#### Steps:
1. **Create a new directory**:
   ```bash
   mkdir projects
   ```
2. **Navigate into the directory**:
   ```bash
   cd projects
   ```
3. **Display your current directory**:
   ```bash
   pwd
   ```
   Expected output: `/home/yourusername/linux_labs/projects`
4. **Create multiple directories**:
   ```bash
   mkdir archive current upcoming
   ```
5. **List the directories**:
   ```bash
   ls
   ```
   Expected output: `archive  current  upcoming`

### Exercise 2: Managing Files

#### Steps:
1. **Create a new file**:
   ```bash
   touch notes.txt
   ```
2. **List the contents using detailed format**:
   ```bash
   ls -l
   ```
3. **Copy the file to a new directory**:
   ```bash
   cp notes.txt archive/
   ```
4. **Verify the copy**:
   ```bash
   cd archive
   ls
   ```
   Expected output: `notes.txt`
5. **Modify the file with text**:
   ```bash
   vim notes.txt
   ```
   *Insert text, then save and exit.*
6. **Display the contents of the file**:
   ```bash
   cat notes.txt
   ```

### Exercise 3: Clean Up

#### Steps:
1. **Remove a file**:
   ```bash
   rm notes.txt
   ```
2. **Remove multiple directories**:
   ```bash
   cd ..
   rm -r archive current upcoming
   ```
3. **Verify cleanup**:
   ```bash
   ls
   ```
   Expected output: Should only display remaining files if any.
Creating lab sessions specifically for Vim and managing symbolic and hard links in Linux will provide practical experience with these important skills. Below is a GitHub-style documentation in Markdown format for these additional lab sessions. This will guide users through hands-on exercises designed to help them become proficient in using Vim and managing links in Linux.

### Exercise 4: Mastering Vim

Vim is a powerful text editor used in many Linux systems. This exercise will introduce you to basic and some intermediate Vim commands.

#### Steps:
1. **Open Vim**:
   ```bash
   vim
   ```
   This command opens Vim. Initially, you'll be in "Normal" mode.
2. **Switch to Insert mode**:
   - Press `i` to enter insert mode where you can start typing text.
3. **Type some text**:
   - Type "Hello, this is my first Vim session."
4. **Save and exit**:
   - Press `ESC` to return to Normal mode.
   - Type `:wq` and press `Enter` to save your changes and exit Vim.
5. **Run cat command on the file to check contents**:
   ```bash
   cat testfile.txt
   ```

### Exercise 5: Creating and Managing Links

Learn how to create symbolic (soft) and hard links, and understand their differences.

#### Steps:
1. **Create a file**:
   ```bash
   touch original.txt
   echo "This is the original file." > original.txt
   ```
2. **Create a symbolic link**:
   ```bash
   ln -s original.txt symlink.txt
   ```
   This creates a symbolic link `symlink.txt` which points to `original.txt`.
3. **Create a hard link**:
   ```bash
   ln original.txt hardlink.txt
   ```
   This creates a hard link `hardlink.txt` that directly references the data of `original.txt`.
4. **Compare changes to the links when modifying the original file**:
   ```bash
   echo "Additional content." >> original.txt
   cat symlink.txt
   cat hardlink.txt
   ```
   Both `symlink.txt` and `hardlink.txt` should show the updated content.
5. **Delete the original file and test the links**:
   ```bash
   rm original.txt
   cat symlink.txt
   cat hardlink.txt
   ```
   The `symlink.txt` will fail to open as it points to a non-existent file, but `hardlink.txt` will still display the content.
