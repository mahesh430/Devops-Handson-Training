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

After running `docker-compose up -d`, you can access the WordPress site by navigating to `http://localhost:8000` in your web browser.

This example and explanation should help you effectively teach Docker Compose and demonstrate its benefits with a practical example. Let me know if you need any further details or have any questions!
