# Lab Sessions on Filtering & I/O Redirection Commands

## Overview

This repository contains lab sessions designed to help learners understand and practice using Unix/Linux command line tools for filtering and I/O redirection. These labs cover commands like `grep`, `more`, `less`, `head`, `tail`, `cut`, `sed`, and various redirection operators.

## Lab Sessions

### Lab 1: Introduction to Filtering with `grep`

**Objective**: Learn to filter lines of text using patterns.

**Instructions**:
1. Open a terminal.
2. Use `grep` to find lines containing specific patterns in text files.

**Examples**:
```bash
grep 'pattern' filename.txt
```

**Exercises**:
1. Find all occurrences of the word "error" in `logfile.txt`.

---

### Lab 2: Paging through Text with `more` and `less`

**Objective**: Learn to view the contents of large text files page by page.

**Instructions**:
1. Use `more` and `less` to read through large logs or files.

**Examples**:
```bash
more largefile.txt
less largefile.txt
```

**Exercises**:
1. Open `example.log` with `less` and search for any errors.

---

### Lab 3: Working with the Start and End of Files using `head` and `tail`

**Objective**: Learn to extract specific lines from the beginnings or ends of files.

**Instructions**:
1. Use `head` to view the first few lines of a file.
2. Use `tail` to view the last few lines of a file.

**Examples**:
```bash
head -n 10 example.txt
tail -n 5 example.txt
```

**Exercises**:
1. Display the first 10 lines of `data.csv`.
2. Show the last 3 lines of `errors.log`.

---

### Lab 4: Extracting Parts of Lines with `cut`

**Objective**: Learn to extract specific columns from delimited data.

**Instructions**:
1. Use `cut` to select fields from delimited text (e.g., CSV).

**Examples**:
```bash
cut -d',' -f1 data.csv
```

**Exercises**:
1. Extract the first column from `records.csv`.

---

### Lab 5: Advanced Text Manipulation with `sed`

**Objective**: Perform advanced text substitutions and deletions.

**Instructions**:
1. Use `sed` for simple text replacements and more complex text manipulations.

**Examples**:
```bash
sed 's/old/new/g' file.txt
```

**Exercises**:
1. Replace all occurrences of "http" with "https" in `urls.txt`.

---

### Lab 6: Mastering I/O Redirection and Pipes

**Objective**: Learn to redirect output and chain commands with pipes.

**Instructions**:
1. Redirect the output of a command to a file.
2. Use pipes to combine commands.

**Examples**:
```bash
grep 'pattern' file.txt > results.txt
cat file.txt | grep 'pattern'
```

**Exercises**:
1. Use `find` to locate all JPEG files and redirect the output to `jpg-files.txt`.

---

## Conclusion

These lab sessions are designed to provide hands-on experience with Unix/Linux command line tools, focusing on practical applications and real-world use cases. Each lab includes exercises to help reinforce learning and encourage exploration.

---

This format can be adapted and expanded based on specific learning goals and the depth of coverage desired. You can add more labs or detailed scenarios to each section to enhance learning opportunities. This structure is also ideal for GitHub, as it allows for version control of lab instructions and easy updates or contributions from other users.
