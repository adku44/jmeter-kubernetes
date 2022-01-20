## Grafana is not presenting data
Can happen that grafana provisioning fails after deployment. Then on grafana dashboard go to default datasource.
Default datasource is influxdb and open configuration panel. Choose 'Test and Save' connection.


## Slave pods hang
Sometimes can happen that slave pods are busy and new tests are not possible to run. Such situation can occurs 
in case of huge nubmers of response errors or improprate closing test scenario by script ```stop-test.sh.
When such situation happen then slaves must be killed manually by command with apropiate slave name.

Kill POD (e.g.)
```
kubectl delete pods -n load-test jmeter-slave-7988854fcb-4zft4
kubectl delete pods -n load-test jmeter-slave-7988854fcb-4zft4 --force
```

Killed pod will be removed and in place of it a new one will be created automatically accordingly to deployment file.

## Deleting kubernetes cluster
Kubernetes cluster shall be deleted by EKSCTL tool. But before 'Load Balancer' must be removed for grafana service and 
in place of it origial service of type 'NodePort' must be restored. After that command 'EKSCTL delete' can be executed
to correctly deleted all components. Otherwise some components remain active. To avoid billing for active components their
must be removed manually on AWS console. In such case please login to AWS console, choose apropriate datacenter location
and check services: EC2 - Instances, EC2 - Load Balancer, EKS.


## How to change grafana dashboard
In presented solution it's possible to change grafana dashboard to another one. The source of the different dashbords for jmeter is grafana web site. All avaiable jmeter load test dashboards are located 
[here](https://grafana.com/grafana/dashboards/?search=jmeter). It's important that each load test dashboard has corresponding backed listener. Because of that two steps are required to change dashboard.
1. Download dashboard definition, it's located in json file and copy to grafana configmap.
2. Update `.jmx` file with corresponding 'backed listener' to the dashboard. This can be found in 'Thread Group' object.

