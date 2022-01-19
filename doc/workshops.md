### Prerequisities

Kubernetes cluster must be running

## Workshops plan step-by-step

### Setting up namespace
```
kubectl get namespaces
```
Create namespace
```
kubectl create namespace qa-workshop
```
Set the namespace as a default working
```
kubectl config set-context --current --namespace=qa-workshop
```
Get the name of current namespace
```
kubectl config view --minify --output 'jsonpath={..namespace}'; echo
```
### Deployment file
```
kubectl create -f ./jmeter/jmeter_slaves_deploy.yaml
kubectl create -f ./jmeter/jmeter_master_deploy.yaml
```
```
kubectl get pods
```
### Configmaps
Deploy configmap to have running master POD
```
kubectl create -f ./jmeter/jmeter_master_configmap.yaml
```
```
kubectl get pods
```

### Kill working POD
```
kubectl delete pod jmeter-master-[...]
```
```
kubectl get pods
```

### Patching deployment file
```
kubectl patch deployment jmeter-slaves -p '{"spec": {"replicas": 1}}'
```
```
kubectl get pods
```

### Service deployment




### Increase number of replicas



### Logging into POD

### Running empty POD

### Provisioning POD

### Running empty POD

### Get detailed information
```
kubectl describe namespaces
```

### Removing deployment
```
kubectl delete -f ./jmeter/jmeter_master_deploy.yaml
```
```
kubectl delete namespace qa-workshop
```

