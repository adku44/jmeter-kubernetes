### Prerequisities

Kubernetes cluster must be running. All commands shall be executeted from git clone repository.

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
kubectl config view | grep namespace
```
### Deployment file
```
kubectl create -f ./jmeter/jmeter_slaves_deploy.yaml
```
```
kubectl create -f ./jmeter/jmeter_master_deploy.yaml
```
```
kubectl get pods
```
> *Notice that master POD is not running* 
### Configmaps
Deploy configmap to have running master POD
```
kubectl create -f ./jmeter/jmeter_master_configmap.yaml
```
```
kubectl get pods
```
> *Wait till master POD state is running* 

### Kill working POD
```
kubectl delete pod jmeter-master-[...]
```
```
kubectl get pods
```
> *Notice that master POD is recreated* 

### Patching deployment file
Change number of slave PODs
```
kubectl patch deployment jmeter-slaves -p '{"spec": {"replicas": 1}}'
```
```
kubectl get pods
```

### Increase number of replicas
Increase number of slave PODs
```
kubectl patch deployment jmeter-slaves -p '{"spec": {"replicas": 3}}'
```

### Service deployment
Get ip addresses of all PODs
```
kubectl get pod -o wide
```
Create a service of type ClusterIP
```
kubectl create -f ./jmeter/jmeter_slaves_svc.yaml
```
Create a service of type NodePort
```
kubectl create -f ./grafana/jmeter_grafana_svc.yaml
```
Get all services
```
kubectl get svc
```
```
kubectl describe svc jmeter-slaves-svc
```

### Logging into POD
```
kubectl get pods
```
> *Take a name of running master POD* 

Login to master POD
```
kubectl exec -it jmeter-master-[...]  -- /bin/sh
```
Check visibility of services from master POD. Execute below commands
from terminal.
```
getent ahostsv4 jmeter-slaves-svc | cut -d' ' -f1 | sort -u 
```
```
getent ahostsv4 grafana | cut -d' ' -f1 | sort -u 
```

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

