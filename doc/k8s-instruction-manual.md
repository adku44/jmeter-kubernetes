
This manual covers basic kubernetes commands to handle POD configuration, patching deployment files (.yaml) 
and handling Load Test application.

## Start/stop kubernetes cluster
`eksctl create cluster --name=LTaas --region=eu-north-1 --nodes=2 --instance-types=t3.small`

`eksctl delete cluster --name=LTaas --region=eu-north-1`

> *About 20 minutes takes to bulid k8s cluster with EKSCTL tool* 

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

Connect to POD (e.g.)
```
kubectl exec -it -n load-test influxdb-6cdb4c7cf8-dpckm  -- /bin/sh
```

Exposure grafana service
```
kubectl get svc grafana-svc -n load-test
kubectl -n load-test patch svc grafana-svc -p '{"spec": {"type": "LoadBalancer"}}'
```
> *About 5 minutes takes deployment of Load Balancer* 

Remove Load Balancer
```
kubectl -n load-test patch svc grafana-svc -p '{"spec": {"type": "NodePort"}}'
```

Increase number of slaves
```
kubectl -n load-test patch deployment jmeter-slaves -p '{"spec": {"replicas": 3}}'
```

## Deployment of Load Test app
Start deployment of all necessary pods
```
./deployment_start.sh
```

Wait untill all pods are running. Check it with command
```
kubectl get -n load-test all
```

## Deploy Dummy POD
Dummy POD is used to simulate tested application.
The POD is built on nginx container and it has defined service 'nginx-bumper' where all 
testing requests will be sent to.  
Test scenario uses requests with two methods: GET and POST. The first method gives success response (200 OK) and the second (POST) gives an error. 
Becasue of that after execution of test scenario from file `demo.jmx` it will be reported 50 % of errors. 

Deploy dummy pod
```
./nginx-start.sh
```

## Start Load Testing
Test scenario is included in `demo.jmx` file. This file is editable by jmeter ui application
and can be customized for own purpose.
Start the demo file 
```
./start-test.sh demo.jmx
```
First observations shall be visible on Grafana dashboard during performing tests. 
Execution of the test scenario shall fininished sucessfully with proper information on the output.
In case if you want to break test during an execution then stop command must be given.  
```
./test-stop.sh
```
