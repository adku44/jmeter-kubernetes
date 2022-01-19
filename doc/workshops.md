### Prerequisities

Kubernetes cluster must be running

## Workshops plan step-by-step

### Setting up namespace
```
kubectl get namespaces
```
```
kubectl create namespace qa_workshop
```
```
kubectl config set-context --current --namespace=qa_workshop
```
### Deployment file
```
kubectl create -f ./jmeter/jmeter_slaves_deploy.yaml
kubectl create -f ./jmeter/jmeter_master_deploy.yaml
```
```
kubectl get pods
```
### Removing working POD
```

```
```

```
### Patching deployment file
```

```
```

```



### Service deployment




### Increase number of replicas



### Logging into POD

### Running empty POD

### Provisioning POD

### Running empty POD

### Removing deployment

```
kubectl delete namespace qa_workshop
```

