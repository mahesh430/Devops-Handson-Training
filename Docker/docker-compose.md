### Docker Compose File

#### `docker-compose.yml`
```yaml
version: '3.8'

services:
  db:
    image: mysql:5.7
    restart: always
    environment:
      MYSQL_ROOT_PASSWORD: example
      MYSQL_DATABASE: wordpress
      MYSQL_USER: wordpress
      MYSQL_PASSWORD: wordpress
    volumes:
      - db_data:/var/lib/mysql

  wordpress:
    image: wordpress:latest
    restart: always
    ports:
      - "8000:80"
    environment:
      WORDPRESS_DB_HOST: db:3306
      WORDPRESS_DB_USER: wordpress
      WORDPRESS_DB_PASSWORD: wordpress
      WORDPRESS_DB_NAME: wordpress
    volumes:
      - wordpress_data:/var/www/html
    depends_on:
      - db

volumes:
  db_data: {}
  wordpress_data: {}
```

### Explanation of `docker-compose.yml`

1. **version**: Specifies the Compose file format version.
   ```yaml
   version: '3.8'
   ```

2. **services**: Defines the services (containers) to be run.
   
   - **db**: The MySQL database service.
     ```yaml
     db:
       image: mysql:5.7
       restart: always
       environment:
         MYSQL_ROOT_PASSWORD: example
         MYSQL_DATABASE: wordpress
         MYSQL_USER: wordpress
         MYSQL_PASSWORD: wordpress
       volumes:
         - db_data:/var/lib/mysql
     ```
     - **image**: The image to use for this service.
     - **restart**: Always restart the container if it stops.
     - **environment**: Environment variables for MySQL configuration.
     - **volumes**: Persistent storage for the database.

   - **wordpress**: The WordPress service.
     ```yaml
     wordpress:
       image: wordpress:latest
       restart: always
       ports:
         - "8000:80"
       environment:
         WORDPRESS_DB_HOST: db:3306
         WORDPRESS_DB_USER: wordpress
         WORDPRESS_DB_PASSWORD: wordpress
         WORDPRESS_DB_NAME: wordpress
       volumes:
         - wordpress_data:/var/www/html
       depends_on:
         - db
     ```
     - **image**: The image to use for this service.
     - **restart**: Always restart the container if it stops.
     - **ports**: Maps port 8000 on the host to port 80 in the container.
     - **environment**: Environment variables for WordPress configuration.
     - **volumes**: Persistent storage for WordPress files.
     - **depends_on**: Ensures the `db` service starts before `wordpress`.

3. **volumes**: Defines named volumes for persistent data.
   ```yaml
   volumes:
     db_data: {}
     wordpress_data: {}
   ```

### Usage of Docker Compose

1. **Creating and Starting Containers**
   - **Command**:
     ```bash
     docker-compose up -d
     ```
   - **Explanation**: This command creates and starts the containers in detached mode (`-d`).

2. **Stopping and Removing Containers**
   - **Command**:
     ```bash
     docker-compose down
     ```
   - **Explanation**: This command stops and removes the containers, networks, and volumes defined in the Compose file.

3. **Viewing Logs**
   - **Command**:
     ```bash
     docker-compose logs
     ```
   - **Explanation**: This command shows the logs from all containers.

4. **Scaling Services**
   - **Command**:
     ```bash
     docker-compose up -d --scale wordpress=3
     ```
   - **Explanation**: This command scales the `wordpress` service to run three instances.

### Benefits of Using Docker Compose

1. **Simplifies Multi-Container Applications**: Docker Compose allows you to define and run multi-container applications with a single configuration file (`docker-compose.yml`).

2. **Centralized Configuration**: All configurations for your services are centralized in one file, making it easy to manage and modify.

3. **Easier Networking**: Docker Compose automatically sets up networking between containers, simplifying service communication.

4. **Volume Management**: It makes it easy to define and manage persistent storage using volumes.

5. **Environment Isolation**: Each Compose project runs in its own namespace, ensuring that containers do not interfere with each other.

6. **Dependency Management**: `depends_on` ensures that services start in the correct order.

### Accessing the WordPress Site



To log in to a MySQL database running inside a Docker container and create tables, you can follow these steps:

1. **Identify the Container ID or Name:**
   First, you need to find out the Container ID or name of the MySQL container. You can do this by running:
   ```sh
   docker ps
   ```
   This will list all running containers. Look for your MySQL container in the list.

2. **Log in to the MySQL Container:**
   You can log in to the MySQL container using the `docker exec` command. Replace `CONTAINER_ID` with the actual Container ID or name of your MySQL container:
   ```sh
   docker exec -it CONTAINER_ID mysql -u root -p
   ```
   You will be prompted to enter the root password. This is the password you set when you started the MySQL container.

3. **Create a Database:**
   Once logged in, you can create a database by running:
   ```sql
   CREATE DATABASE your_database_name;
   ```

4. **Use the Database:**
   Select the database you just created:
   ```sql
   USE your_database_name;
   ```

5. **Create Tables:**
   Now you can create tables within the selected database. Here is an example of how to create a table:
   ```sql
   CREATE TABLE your_table_name (
       id INT AUTO_INCREMENT PRIMARY KEY,
       name VARCHAR(255) NOT NULL,
       age INT,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );
   ```

Here is a step-by-step example:

### Example

1. **Find the MySQL Container ID or Name:**
   ```sh
   docker ps
   ```

2. **Log in to the MySQL Container:**
   ```sh
   docker exec -it mysql_container_name mysql -u root -p
   ```

3. **Enter the Root Password:**
   ```sh
   Enter password: your_password
   ```

4. **Create a Database:**
   ```sql
   CREATE DATABASE example_db;
   ```

5. **Use the Database:**
   ```sql
   USE example_db;
   ```

6. **Create a Table:**
   ```sql
   CREATE TABLE users (
       id INT AUTO_INCREMENT PRIMARY KEY,
       username VARCHAR(255) NOT NULL,
       email VARCHAR(255) NOT NULL,
       created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
   );
   ```

```sql
INSERT INTO users (username, email) VALUES ('john_doe', 'john.doe@example.com');
INSERT INTO users (username, email) VALUES ('jane_smith', 'jane.smith@example.com');
INSERT INTO users (username, email) VALUES ('alice_johnson', 'alice.johnson@example.com');
INSERT INTO users (username, email) VALUES ('bob_brown', 'bob.brown@example.com');
INSERT INTO users (username, email) VALUES ('charlie_davis', 'charlie.davis@example.com');

```
By following these steps, you can log in to your MySQL container, create databases, and create tables within those databases.

After running `docker-compose up -d`, you can access the WordPress site by navigating to `http://localhost:8000` in your web browser.

This example and explanation should help you effectively teach Docker Compose and demonstrate its benefits with a practical example. Let me know if you need any further details or have any questions!
