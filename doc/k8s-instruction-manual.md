
This manual covers basic kubernetes commands to handle POD configuration, patching deployments files (.yaml) 
and handle LTaaS application.

## Start/stop kubernetes cluster
`eksctl create cluster --name=LTaas --region=eu-north-1 --nodes=2 --instance-types=t3.small`

`eksctl delete cluster --name=LTaas --region=eu-north-1`

> *About 20 minutes takes buliding k8s cluster with EKSCTL tool* 

## Basic Commands
Check namespaces and PODs
```
kubectl get namespace
kubectl get po -n load-test
kubectl get po -n load-test | grep jmeter-master | awk '{print $1}'
```
Check deployment
```
kubectl get deployment -n load-test all
```

Remove namespace
```
kubectl delete namespace load-test
```

Kill POD (e.g.)
```
kubectl delete pods -n load-test jmeter-slave-7988854fcb-4zft4
kubectl delete pods -n load-test jmeter-slave-7988854fcb-4zft4 --force
```

Connect to POD (e.g.)
```
kubectl exec -it -n load-test jmeter-grafana-6cdb4c7cf8-dpckm  -- /bin/sh
```
Exposure grafana service
```
kubectl get svc jmeter-grafana -n load-test
kubectl -n load-test patch svc jmeter-grafana -p '{"spec": {"type": "LoadBalancer"}}'
```
Remove Load Balancer
```
kubectl -n load-test patch svc jmeter-grafana -p '{"spec": {"type": "NodePort"}}'
```
Increase number of slaves
```
kubectl -n load-test patch deployment jmeter-slaves -p '{"spec": {"replicas": 3}}'
```

## Deployment of LTaaS app
Start deployment of all necessary pods
```
./deploy-load-test-app.sh
```
Wait untill all pods are running. Check it with command
```
kubectl get -n load-test all
```
When all pods are running then perform configuration setup
```
./configure-pods.sh
```

## Start Load Testing
Test scenario is included in demo.jmx file. This file is maintened by jmeter ui application
and can be customized for own purpose.
Start the demo file 
```
./start-test.sh demo.jmx
```
First observations shall be visible on Grafana dashboard during performing tests. 
Execution of the test scenario shall fininished sucessfully with proper information on the output.
In case if you want to break test during an execution then stop command must be given.  
```
./stop-test.sh
```
## Troubleshooting