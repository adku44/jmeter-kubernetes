#!/usr/bin/env bash

working_dir=`pwd`

#Get namesapce variable
namespace=`awk '{print $NF}' $working_dir/namespace-for-k8s`

## Create jmeter database automatically in Influxdb

echo "Creating Influxdb jmeter Database"

##Wait until Influxdb Deployment is up and running
##influxdb_status=`kubectl get po -n $namespace | grep influxdb-jmeter | awk '{print $2}' | grep Running

influxdb_pod=`kubectl get po -n $namespace | grep influxdb | awk '{print $1}'`
kubectl exec -ti -n $namespace $influxdb_pod -- influx -execute 'CREATE DATABASE jmeter'

## Create the influxdb datasource in Grafana

echo "Creating the Influxdb data source"
grafana_pod=`kubectl get po -n $namespace | grep grafana | awk '{print $1}'`

## Make load test script in Jmeter master pod executable

#Get Master pod details

master_pod=`kubectl get po -n $namespace | grep jmeter-master | awk '{print $1}'`

kubectl exec -ti -n $namespace $master_pod -- cp -r /load_test /jmeter/load_test

kubectl exec -ti -n $namespace $master_pod -- chmod 755 /jmeter/load_test

##kubectl cp $working_dir/influxdb-jmeter-datasource.json -n $tenant $grafana_pod:/influxdb-jmeter-datasource.json

#kubectl exec -ti -n $namespace $grafana_pod -- curl 'http://admin:admin@127.0.0.1:3000/api/datasources' -X POST -H 'Content-Type: application/json;charset=UTF-8' --data-binary '{"name":"jmeterdb","type":"influxdb","url":"http://influxdb:8086","access":"proxy","isDefault":true,"database":"jmeter","user":"admin","password":"admin"}'
