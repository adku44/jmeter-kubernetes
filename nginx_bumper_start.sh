#!/usr/bin/env bash
# Create dummy pod to simulate tested application. 
# Test scenario will be able to run inside kubernetes cluster.
# 
# January 14, 2022
# by adku44 

working_dir=`pwd`

# Read namesapce from file
namespace=`awk '{print $NF}' $working_dir/namespace-for-k8s`

# dummy bumper

echo "Creating dummy bumper POD"

kubectl create -n $namespace -f $working_dir/jmeter/dummy-pod/nginx_bumper_deploy.yaml
kubectl create -n $namespace -f $working_dir/jmeter/dummy-pod/nginx_bumper_svc.yaml

echo "Created service for dummy bumper:"
kubectl get svc nginx-bumper -n $namespace
