### Example 1: Using `CMD`

#### Dockerfile with CMD
```dockerfile
# Use a base image
FROM centos:7

# Use CMD to sleep for 10 seconds
CMD ["sleep", "10"]
```

#### Explanation:
- **CMD ["sleep", "10"]**: This sets the default command to `sleep 10`. You can override this at runtime by providing a different command.
- If you run the container without overriding CMD, it will sleep for 10 seconds:
  ```bash
  docker run my-centos-cmd
  ```
- If you want to override the sleep time at runtime, you can specify a different sleep duration:
  ```bash
  docker run my-centos-cmd sleep 20
  ```
  This will override the CMD and make the container sleep for 20 seconds.

### Example 2: Using `ENTRYPOINT`

#### Dockerfile with ENTRYPOINT
```dockerfile
# Use a base image
FROM centos:7

# Use ENTRYPOINT to run sleep
ENTRYPOINT ["sleep"]
```

#### Explanation:
- **ENTRYPOINT ["sleep"]**: This sets the entrypoint to `sleep`. Arguments provided at runtime will be appended to the entrypoint command.
- You must provide an argument for `sleep` at runtime:
  ```bash
  docker run my-centos-entrypoint 10
  ```
  This will make the container sleep for 10 seconds.
- You can change the sleep duration by providing different arguments:
  ```bash
  docker run my-centos-entrypoint 20
  ```
  This will make the container sleep for 20 seconds.

### Example 3: Using CMD and ENTRYPOINT Together

#### Dockerfile with CMD and ENTRYPOINT
```dockerfile
# Use a base image
FROM centos:7

# Set the entrypoint to sleep
ENTRYPOINT ["sleep"]

# Provide a default argument for sleep
CMD ["10"]
```

#### Explanation:
- **ENTRYPOINT ["sleep"]**: Sets the entrypoint to `sleep`.
- **CMD ["10"]**: Provides a default argument of `10` seconds for the `sleep` command.
- If you run the container without additional arguments, it will use the default CMD value:
  ```bash
  docker run my-centos-entrypoint-cmd
  ```
  This will make the container sleep for 10 seconds.
- If you want to override the sleep duration, you can specify a different value:
  ```bash
  docker run my-centos-entrypoint-cmd 20
  ```
  This will override the CMD value and make the container sleep for 20 seconds.

### Summary
- **Using CMD**: Sets a default command that can be completely overridden at runtime.
- **Using ENTRYPOINT**: Sets the main command to be run, and arguments provided at runtime are appended to this command.
- **Using CMD and ENTRYPOINT together**: Sets a main command with a default argument that can be overridden at runtime. The ENTRYPOINT command cannot be overridden, but the CMD argument can be changed.

By understanding these examples, you can see how `CMD` and `ENTRYPOINT` behave differently and how to use them to control the behavior of your Docker containers.
