apiVersion: apps/v1
kind: Deployment
metadata:
  creationTimestamp: null
  labels:
    app: nodejs-server
    migrate-for-anthos-type: workload
  name: nodejs-server
spec:
  replicas: 3
  selector:
    matchLabels:
      app: nodejs-server
      migrate-for-anthos-type: workload
  strategy: {}
  template:
    metadata:
      creationTimestamp: null
      labels:
        app: nodejs-server
        migrate-for-anthos-type: workload
    spec:
      containers:
      - image: gcr.io/project-id/nodejs-server:latest
        name: nodejs-server
        securityContext:
          privileged: true
        ports:
        - containerPort: 3000
        volumeMounts:
        - mountPath: /sys/fs/cgroup
          name: cgroups
      volumes:
      - hostPath:
          path: /sys/fs/cgroup
          type: Directory
        name: cgroups
---
apiVersion: v1
kind: Service
metadata:
  name: nodejs-server
spec:
  selector:
    app: nodejs-server
  type: NodePort
  ports:
    - protocol: TCP
      port: 80
      targetPort: 3000
  type: LoadBalancer
