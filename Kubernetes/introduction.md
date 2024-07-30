Sure, here is a consolidated note that covers Kubernetes architecture, Pods, Services (with types), Deployments, and basic operations like logging into Pods and checking logs.

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
        image: nginx
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
         port: 80
         targetPort: 80
         nodePort: 30007
       type: NodePort
     ```
     ```bash
     kubectl apply -f service.yaml
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

## Accessing the Kubernetes Dashboard

1. **Install the Dashboard**:
   ```bash
   kubectl apply -f https://raw.githubusercontent.com/kubernetes/dashboard/v2.2.0/aio/deploy/recommended.yaml
   ```

2. **Start the Dashboard Proxy**:
   ```bash
   kubectl proxy
   ```

3. **Access the Dashboard**:
   Open a web browser and navigate to:
   ```
   http://localhost:8001/api/v1/namespaces/kubernetes-dashboard/services/https:kubernetes-dashboard:/proxy/
   ```

4. **Create a Service Account and ClusterRoleBinding for Dashboard Access**:
   ```yaml
   apiVersion: v1
   kind: ServiceAccount
   metadata:
     name: admin-user
     namespace: kubernetes-dashboard
   ---
   apiVersion: rbac.authorization.k8s.io/v1
   kind: ClusterRoleBinding
   metadata:
     name: admin-user
   roleRef:
     apiGroup: rbac.authorization.k8s.io
     kind: ClusterRole
     name: cluster-admin
   subjects:
   - kind: ServiceAccount
     name: admin-user
     namespace: kubernetes-dashboard
   ```
   ```bash
   kubectl apply -f dashboard-admin.yaml
   ```

5. **Get the Token for the Dashboard Login**:
   ```bash
   kubectl -n kubernetes-dashboard create token admin-user
   ```

   Use this token to log in to the Kubernetes Dashboard.

This note should provide a comprehensive overview for your Kubernetes classes.
