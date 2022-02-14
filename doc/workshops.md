This workshops plan covers basic kubernetes commands to handle POD configuration, patching deployment files (.yaml), logging into PODs.
Aim of the workshops is explanation of namespace, concept of config maps and services.

The plan is based on Load Test application.


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
kubectl create -f ./grafana/grafana_svc.yaml
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
kubectl get pods -o wide
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
getent ahostsv4 grafana-svc | cut -d' ' -f1 | sort -u 
```
> *The commands resolve host names and give IP addresses associated with the services* 

### Running POD with idle container
```
kubectl get pods
```
Remove deployment of master POD
```
kubectl delete -f ./jmeter/jmeter_master_deploy.yaml
```
> *Wait till deployment is not visible by command `kubectl get pods`*

Edit file `./jmeter/jmeter_master_deploy.yaml`
```
nano ./jmeter/jmeter_master_deploy.yaml
```
Go to line 22 `ctrl-_` and comment lines: 22 and 23

`ctrl-x` save and close the file.
> *Keys `command` and `args` will not be executed during deployment of the POD*

Redeploy master POD
```
kubectl create -f ./jmeter/jmeter_master_deploy.yaml
```
Check status of the POD
```
kubectl get pods
```
> *master POD is not running, but its state is completed*

Remove deployment of master POD
```
kubectl delete -f ./jmeter/jmeter_master_deploy.yaml
```
Restore file `./jmeter/jmeter_master_deploy.yaml` to its original version by removing `#` tags and redeploy a new one

### Get detailed information
```
kubectl describe namespaces
```
```
kubectl describe -f ./jmeter/jmeter_master_deploy.yaml
```
```
kubectl describe pod jmeter-slaves-[...]
```

### Removing deployment
Remove service 
```
kubectl delete -f ./jmeter/jmeter_slaves_svc.yaml
```
Remove deployment 
```
kubectl delete -f ./jmeter/jmeter_slaves_deploy.yaml
```
Remove namespace
```
kubectl delete namespace qa-workshop
```

