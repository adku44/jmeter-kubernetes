#!/usr/bin/env bash
#Create dummy pod to simulate tested application. Test scenario will be able to run inside kubernetes cluster.
#January 14, 2022
#by adku44 

working_dir=`pwd`

#Read namesapce from file
namespace=`awk '{print $NF}' $working_dir/namespace-for-k8s`

echo "Checking if kubectl is present"

if ! hash kubectl 2>/dev/null
then
    echo "'kubectl' was not found in PATH"
    echo "Kindly ensure access to kubernetes cluster"
    exit
fi

# dummy bumper

echo "Creating dummy bumper pod"

kubectl create -n $namespace -f $working_dir/jmeter/dummy-pod/nginx_bumper_deploy.yaml
kubectl create -n $namespace -f $working_dir/jmeter/dummy-pod/nginx_bumper_svc.yaml

echo "Print created service"
kubectl get svc nginx-bumper -n $namespace
