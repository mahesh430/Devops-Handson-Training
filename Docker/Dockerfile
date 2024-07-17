### Example Dockerfile

```Dockerfile
# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Spring Boot application JAR file to the container
COPY target/my-spring-boot-app.jar /app/my-spring-boot-app.jar

# Expose the port the application runs on
EXPOSE 8080

# Command to run the Spring Boot application
ENTRYPOINT ["java", "-jar", "my-spring-boot-app.jar"]
```

### Explanation of the Dockerfile

1. **FROM openjdk:17-jdk-slim**: This specifies the base image to use, which is an official OpenJDK 17 image with a slim configuration.
2. **WORKDIR /app**: This sets the working directory inside the container to `/app`.
3. **COPY target/my-spring-boot-app.jar /app/my-spring-boot-app.jar**: This copies the JAR file from the `target` directory on your host machine to the `/app` directory inside the container. Make sure to replace `my-spring-boot-app.jar` with the actual name of your JAR file.
4. **EXPOSE 8080**: This exposes port 8080 on the container, which is the default port that Spring Boot runs on.
5. **ENTRYPOINT ["java", "-jar", "my-spring-boot-app.jar"]**: This specifies the command to run the Spring Boot application when the container starts.

### Steps to Build and Run the Docker Container

1. **Build your Spring Boot application JAR file:**

   Make sure you have built your Spring Boot application using Maven or Gradle. The JAR file should be in the `target` directory.

   ```sh
   mvn clean package
   ```

2. **Build the Docker image:**

   Run the following command from the directory containing the Dockerfile:

   ```sh
   docker build -t my-spring-boot-app .
   ```

   Replace `my-spring-boot-app` with your desired image name.

3. **Run the Docker container:**

   Run the following command to start a container from the image:

   ```sh
   docker run -p 8080:8080 my-spring-boot-app
   ```

   This maps port 8080 on your host machine to port 8080 on the container, allowing you to access the Spring Boot application at `http://localhost:8080`.

### Example Directory Structure

Your project directory should look something like this:

```
my-spring-boot-project/
├── Dockerfile
├── src/
│   └── main/
│       └── java/
│           └── com/
│               └── example/
│                   └── MySpringBootApplication.java
├── target/
│   └── my-spring-boot-app.jar
└── pom.xml (or build.gradle)
```

Ensure that the JAR file name in the Dockerfile matches the actual JAR file name generated in the `target` directory.
