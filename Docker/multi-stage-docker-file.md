### Example 1: Basic Dockerfile

```dockerfile
# Use an official OpenJDK runtime as a parent image
FROM openjdk:17-jdk-slim

# Set the working directory in the container
WORKDIR /app

# Copy the Spring Boot application JAR file to the container
COPY target/inventory-0.0.1-SNAPSHOT.jar /app/inventory-0.0.1-SNAPSHOT.jar

# Expose the port the application runs on
EXPOSE 8080

# Command to run the Spring Boot application
CMD ["java", "-jar", "inventory-0.0.1-SNAPSHOT.jar"]
```

#### Explanation:
1. **FROM openjdk:17-jdk-slim**: This line specifies the base image. It uses the official OpenJDK 17 runtime with a slim variant, which is a minimalistic version to reduce the image size.
2. **WORKDIR /app**: Sets the working directory inside the container to `/app`.
3. **COPY target/inventory-0.0.1-SNAPSHOT.jar /app/inventory-0.0.1-SNAPSHOT.jar**: Copies the built JAR file from the local `target` directory to the `/app` directory in the container.
4. **EXPOSE 8080**: Informs Docker that the container listens on port 8080. This is used for documentation purposes and by tools to know which port to expose.
5. **CMD ["java", "-jar", "inventory-0.0.1-SNAPSHOT.jar"]**: Specifies the command to run the Spring Boot application when the container starts.

### Example 2: Multi-stage Build with Maven and OpenJDK Slim

```dockerfile
# Stage 1: Build the application
FROM maven:3.8.5-openjdk-17 AS builder

# Set the working directory
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Create the final image
FROM openjdk:17-jdk-slim

# Set the working directory
WORKDIR /app

# Copy the Spring Boot jar from the builder stage
COPY --from=builder /app/target/inventory-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
```

#### Explanation:
1. **Stage 1: Build the application**
   - **FROM maven:3.8.5-openjdk-17 AS builder**: Uses a Maven image with OpenJDK 17 for the build stage.
   - **WORKDIR /app**: Sets the working directory inside the container to `/app`.
   - **COPY pom.xml .**: Copies the `pom.xml` to the container.
   - **RUN mvn dependency:go-offline**: Downloads all the dependencies needed for the build.
   - **COPY src ./src**: Copies the source code to the container.
   - **RUN mvn clean package -DskipTests**: Builds the application, creating a JAR file without running tests.

2. **Stage 2: Create the final image**
   - **FROM openjdk:17-jdk-slim**: Uses the slim version of OpenJDK 17 for the runtime.
   - **WORKDIR /app**: Sets the working directory inside the container to `/app`.
   - **COPY --from=builder /app/target/inventory-0.0.1-SNAPSHOT.jar app.jar**: Copies the built JAR file from the builder stage to the runtime stage.
   - **EXPOSE 8080**: Informs Docker that the container listens on port 8080.
   - **ENTRYPOINT ["java", "-jar", "app.jar"]**: Specifies the command to run the Spring Boot application.

### Example 3: Multi-stage Build with Maven and Eclipse Temurin Alpine

```dockerfile
# Stage 1: Build the application
FROM maven:3.8.5-openjdk-17 AS builder

# Set the working directory
WORKDIR /app

# Copy the pom.xml and download dependencies
COPY pom.xml .
RUN mvn dependency:go-offline

# Copy the source code
COPY src ./src

# Build the application
RUN mvn clean package -DskipTests

# Stage 2: Create the final image
FROM eclipse-temurin:17-jdk-alpine

# Set the working directory
WORKDIR /app

# Copy the Spring Boot jar from the builder stage
COPY --from=builder /app/target/inventory-0.0.1-SNAPSHOT.jar app.jar

# Expose the application port
EXPOSE 8080

# Run the Spring Boot application
ENTRYPOINT ["java", "-jar", "app.jar"]
```

#### Explanation:
1. **Stage 1: Build the application**
   - Same as in Example 2.

2. **Stage 2: Create the final image**
   - **FROM eclipse-temurin:17-jdk-alpine**: Uses the Eclipse Temurin JDK 17 with an Alpine base, which is even more minimalistic and lightweight compared to the slim variant.
   - **WORKDIR /app**: Sets the working directory inside the container to `/app`.
   - **COPY --from=builder /app/target/inventory-0.0.1-SNAPSHOT.jar app.jar**: Copies the built JAR file from the builder stage to the runtime stage.
   - **EXPOSE 8080**: Informs Docker that the container listens on port 8080.
   - **ENTRYPOINT ["java", "-jar", "app.jar"]**: Specifies the command to run the Spring Boot application.

### Summary
- **Example 1**: A straightforward Dockerfile that copies the pre-built JAR and runs it. Simple but doesn't leverage multi-stage builds.
- **Example 2**: A multi-stage build that separates the build environment from the runtime environment, using `openjdk:17-jdk-slim` for the runtime. This reduces the final image size by not including build tools.
- **Example 3**: Similar to Example 2, but uses `eclipse-temurin:17-jdk-alpine` for the runtime stage, which is even more minimalistic, leading to a smaller final image size.

By choosing the appropriate base image, especially in the runtime stage, you can significantly reduce the size of your Docker image.
