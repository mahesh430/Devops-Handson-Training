## Kubernetes Architecture

https://www.researchgate.net/publication/359854260/figure/fig1/AS:1147677467250690@1650639039609/Kubernetes-architecture.png
### Master Node Components
- **API Server**: Exposes the Kubernetes API, the central control plane.
- **etcd**: Key-value store for cluster data.
- **Controller Manager**: Ensures the desired state of the cluster.
- **Scheduler**: Assigns workloads to nodes.

### Worker Node Components
- **Kubelet**: Ensures containers are running in a Pod.
- **Kube-proxy**: Manages network rules for Pods.
- **Container Runtime**: Runs containers (e.g., Docker).

## Pods
- **Pod**: The smallest deployable unit in Kubernetes. A Pod can contain one or more containers.
- **Creating a Pod**:
  - Imperative: `kubectl run my-pod --image=nginx --restart=Never`
  - Declarative:
    ```yaml
    apiVersion: v1
    kind: Pod
    metadata:
      name: my-pod
    spec:
      containers:
      - name: my-container
        image: mahesh430/aws-inventory-app:5
    ```
    ```bash
    kubectl apply -f pod.yaml
    ```

## Services
- **Service**: Exposes a set of Pods and provides a stable endpoint for them.

### Types of Services
1. **ClusterIP**: Exposes the service on a cluster-internal IP.
   - Example:
     ```yaml
     apiVersion: v1
     kind: Service
     metadata:
       name: my-service
     spec:
       selector:
         app: my-app
       ports:
       - protocol: TCP
         port: 80
         targetPort: 80
       type: ClusterIP
     ```
     ```bash
     kubectl apply -f service.yaml
     ```

2. **NodePort**: Exposes the service on each Node's IP at a static port.
   - Example:
     ```yaml
     apiVersion: v1
     kind: Service
     metadata:
       name: my-service
     spec:
       selector:
         app: my-app
       ports:
       - protocol: TCP
         port: 80   # Service Port: The port exposed by the Service
         targetPort: 8080  # Target Port: The port on the Pod that traffic will be forwarded to
         nodePort: 30020  # NodePort: The port on each node for external access (if type is NodePort)
       type: NodePort  # Type of Service, which in this case is NodePort
     ```
     ```bash
     kubectl apply -f service.yaml
     

     kubectl port-forward my-app 30020:8080
     ```

3. **LoadBalancer**: Exposes the service externally using a cloud provider's load balancer.
   - Example:
     ```yaml
     apiVersion: v1
     kind: Service
     metadata:
       name: my-service
     spec:
       selector:
         app: my-app
       ports:
       - protocol: TCP
         port: 80
         targetPort: 80
       type: LoadBalancer
     ```
     ```bash
     kubectl apply -f service.yaml
     ```

4. **ExternalName**: Maps a service to a DNS name.
   - Example:
     ```yaml
     apiVersion: v1
     kind: Service
     metadata:
       name: my-service
     spec:
       type: ExternalName
       externalName: example.com
     ```
     ```bash
     kubectl apply -f service.yaml
     ```

## Deployments
- **Deployment**: Manages ReplicaSets and ensures the desired number of Pod replicas.
- **Creating a Deployment**:
  - Imperative: `kubectl create deployment my-deployment --image=nginx`
  - Declarative:
    ```yaml
    apiVersion: apps/v1
    kind: Deployment
    metadata:
      name: my-deployment
    spec:
      replicas: 3
      selector:
        matchLabels:
          app: my-app
      template:
        metadata:
          labels:
            app: my-app
        spec:
          containers:
          - name: my-container
            image: nginx
    ```
    ```bash
    kubectl apply -f deployment.yaml
    ```
- **Scaling a Deployment**:
  ```bash
  kubectl scale deployment my-deployment --replicas=5
  ```
- **Updating a Deployment**:
  ```bash
  kubectl set image deployment/my-deployment my-container=nginx:latest
  ```

## Interacting with Pods

### Logging into a Pod
- **Get a shell inside a Pod**:
  ```bash
  kubectl exec -it my-pod -- /bin/bash
  ```

### Checking Logs of a Pod
- **Check the logs of a container in a Pod**:
  ```bash
  kubectl logs my-pod
  ```
  
### Kubernetes Volumes

**Definition**:
Kubernetes Volumes provide a way to persist data beyond the lifecycle of individual Pods. They are essentially directories that are shared between containers in a Pod.

**Types**:
- **emptyDir**: A temporary directory that gets created when a Pod is assigned to a node and is deleted when the Pod is removed.
- **hostPath**: Mounts a file or directory from the host node’s filesystem into a Pod.
- **nfs**: Mounts an NFS (Network File System) share into a Pod.
- **awsElasticBlockStore**: Mounts an AWS EBS volume into a Pod.
- **azureDisk**: Mounts an Azure Disk into a Pod.

**Example**:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: my-container
    image: nginx
    volumeMounts:
    - name: my-volume
      mountPath: /usr/share/nginx/html
  volumes:
  - name: my-volume
    emptyDir: {}
```

In this example, an `emptyDir` volume is used. It creates a temporary directory that will be mounted into the container at `/usr/share/nginx/html`.

### Persistent Volumes (PVs) and Persistent Volume Claims (PVCs)

**Persistent Volumes (PVs)**:
- **Definition**: Represents a piece of storage in the cluster. PVs are a way to abstract storage and provide it to Pods.
- **Lifecycle**: Managed by the cluster, and their lifecycle is independent of Pods.

**Persistent Volume Claims (PVCs)**:
- **Definition**: A request for storage by a user. PVCs are used to request specific storage resources from available PVs.

**Example**:

1. **Persistent Volume (PV)**:

```yaml
apiVersion: v1
kind: PersistentVolume
metadata:
  name: my-pv
spec:
  capacity:
    storage: 10Gi
  accessModes:
    - ReadWriteOnce
  hostPath:
    path: /mnt/data
```

This `PersistentVolume` uses `hostPath` to mount storage from the host node’s filesystem.

2. **Persistent Volume Claim (PVC)**:

```yaml
apiVersion: v1
kind: PersistentVolumeClaim
metadata:
  name: my-pvc
spec:
  accessModes:
    - ReadWriteOnce
  resources:
    requests:
      storage: 10Gi
```

The `PersistentVolumeClaim` requests 10 Gi of storage with `ReadWriteOnce` access mode.

3. **Pod using PVC**:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: my-container
    image: nginx
    volumeMounts:
    - name: my-storage
      mountPath: /usr/share/nginx/html
  volumes:
  - name: my-storage
    persistentVolumeClaim:
      claimName: my-pvc
```

This Pod uses the `PersistentVolumeClaim` to mount the storage at `/usr/share/nginx/html`.

### ConfigMaps

**Definition**:
ConfigMaps allow you to decouple configuration artifacts from container images. They can be used to store configuration data in key-value pairs.

**Usage**:
- Pass configuration data to Pods.
- Provide configuration to applications in a standardized way.

**Example**:

1. **ConfigMap Definition**:

```yaml
apiVersion: v1
kind: ConfigMap
metadata:
  name: my-configmap
data:
  database_url: "mongodb://localhost:27017"
  log_level: "debug"
```

2. **Pod using ConfigMap**:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: my-container
    image: nginx
    env:
    - name: DATABASE_URL
      valueFrom:
        configMapKeyRef:
          name: my-configmap
          key: database_url
    - name: LOG_LEVEL
      valueFrom:
        configMapKeyRef:
          name: my-configmap
          key: log_level
```

In this example, environment variables in the container are populated from values in the `ConfigMap`.

### Secrets

**Definition**:
Secrets are used to store sensitive data, such as passwords, OAuth tokens, or ssh keys. Unlike ConfigMaps, Secrets are encoded in base64 to avoid accidental exposure.

**Usage**:
- Store sensitive information that should not be in plain text.

**Example**:

1. **Secret Definition**:

```yaml
apiVersion: v1
kind: Secret
metadata:
  name: my-secret
type: Opaque
data:
  username: dXNlcg==      # base64 encoded 'user'
  password: cGFzc3dvcmQ=  # base64 encoded 'password'
```

2. **Pod using Secret**:

```yaml
apiVersion: v1
kind: Pod
metadata:
  name: my-pod
spec:
  containers:
  - name: my-container
    image: nginx
    env:
    - name: DATABASE_USER
      valueFrom:
        secretKeyRef:
          name: my-secret
          key: username
    - name: DATABASE_PASSWORD
      valueFrom:
        secretKeyRef:
          name: my-secret
          key: password
```

In this example, environment variables are populated from the `Secret` values.

### Summary

- **Volumes**: Temporary or persistent storage options for Pods. Types include `emptyDir`, `hostPath`, `nfs`, etc.
- **Persistent Volumes (PVs)**: Storage resources managed by Kubernetes, independent of Pods.
- **Persistent Volume Claims (PVCs)**: Requests for storage that Pods use.
- **ConfigMaps**: Store non-sensitive configuration data in key-value pairs.
- **Secrets**: Store sensitive data securely, encoded in base64.

These resources provide essential functionality for managing storage and configuration in Kubernetes.
