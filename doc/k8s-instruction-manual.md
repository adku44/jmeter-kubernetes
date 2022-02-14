
This manual covers basic kubernetes commands to handle POD configuration, patching deployment files (.yaml) 
and handling Load Test application.

## Start/stop kubernetes cluster
Please provide your unique name in place of `[...]`
```
eksctl create cluster --name=LTaas[...] --region=eu-west-2 --nodes=2 --instance-types=t3.large
```
> *About 20 minutes takes to bulid k8s cluster with EKSCTL tool* 

```
eksctl delete cluster --name=LTaas[...] --region=eu-west-2
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
./nginx_bumper_start.sh
```

## Deploy Load Banacer
Exposure grafana service to external IP address
```
kubectl get svc grafana-svc -n load-test
kubectl -n load-test patch svc grafana-svc -p '{"spec": {"type": "LoadBalancer"}}'
```
> *About 5 minutes takes deployment of Load Balancer* 


## Start Load Testing
Now Load Test service is deployed with all necessary components. The service is ready to run. 
Test scenario is included in `demo.jmx` file. This file is editable by jmeter ui application
and can be customized for your own purpose.
Start the demo file 
```
./start_test.sh demo.jmx
```
First observations shall be visible on Grafana dashboard during performing tests. 
Execution of the test scenario shall fininished sucessfully with proper information on the output.
In case if you want to break test during an execution then stop command must be given.  
```
./test_stop.sh
```

## Change number of slaves 
Increase number of slaves
```
kubectl -n load-test patch deployment jmeter-slaves -p '{"spec": {"replicas": 3}}'
```
Decrease number of slaves
```
kubectl -n load-test patch deployment jmeter-slaves -p '{"spec": {"replicas": 1}}'
```

## Remove Load Test service 
Simple remove the namespace to wipe out Load Test service. All components created with the namespace will be removed i.e. load balacer, services, deployments, conig maps etc.
```
kubectl delete namespace load-test
```

## Basic Commands
Check namespaces and PODs
```
kubectl get namespace
kubectl get po -n load-test
kubectl get po -n load-test | grep jmeter-master | awk '{print $1}'
```
Check deployment
```
kubectl get deployment -n load-test
```

Connect to POD (e.g.)
```
kubectl exec -it -n load-test influxdb-6cdb4c7cf8-dpckm  -- /bin/sh
```

Remove Load Balancer
```
kubectl -n load-test patch svc grafana-svc -p '{"spec": {"type": "NodePort"}}'
```

