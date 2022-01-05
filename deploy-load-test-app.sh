#!/usr/bin/env bash
#Create jmeter Load Test application on kuberntes cluster
#January 05, 2022
#by adku44 

working_dir=`pwd`

#Get namesapce variable
tenant=`awk '{print $NF}' $working_dir/namespace-for-k8s`

echo "Checking if kubectl is present"

if ! hash kubectl 2>/dev/null
then
    echo "'kubectl' was not found in PATH"
    echo "Kindly ensure access to kubernetes cluster"
    exit
fi

kubectl version --short
echo

#Check If namespace exists

kubectl get namespace $tenant > /dev/null 2>&1

if [ $? -eq 0 ]
then
  echo "Namespace $tenant already exists, please select a unique name or remove existing"
  echo "Current list of namespaces on the kubernetes cluster"
  sleep 2

  kubectl get namespaces | grep -v NAME | awk '{print $1}'
  exit 1
fi

echo
echo "Creating Namespace: $tenant"

kubectl create namespace $tenant

echo "Namspace $tenant has been created"
echo

# jmeter

echo "Creating Jmeter slave pods"

kubectl create -n $tenant -f $working_dir/jmeter/jmeter_slaves_deploy.yaml

kubectl create -n $tenant -f $working_dir/jmeter/jmeter_slaves_svc.yaml

echo "Creating Jmeter master pod"

kubectl create -n $tenant -f $working_dir/jmeter/jmeter_master_configmap.yaml

kubectl create -n $tenant -f $working_dir/jmeter/jmeter_master_deploy.yaml

# Influxdb

echo "Deploying Influxdb config maps" 
kubectl create -n $tenant -f $working_dir/influx/jmeter_influxdb_configmap.yaml

echo "Creating Influxdb pod and service"
kubectl create -n $tenant -f $working_dir/influx/jmeter_influxdb_deploy.yaml

kubectl create -n $tenant -f $working_dir/influx/jmeter_influxdb_svc.yaml

# Grafana

echo "Deploying Grafana config maps"  



echo "Creating Grafana pod and service"
kubectl create -n $tenant -f $working_dir/grafana/jmeter_grafana_deploy.yaml

kubectl create -n $tenant -f $working_dir/grafana/jmeter_grafana_svc.yaml

sleep 2

echo "Printout Of the $tenant Objects"
echo

kubectl get -n $tenant all

echo "All pods have been created"
