#!/usr/bin/env bash
#Script writtent to stop a running jmeter master test
#Kindly ensure you have the necessary kubeconfig

working_dir=`pwd`

#Get namesapce variable
namespace=`awk '{print $NF}' $working_dir/namespace-for-k8s`

master_pod=`kubectl get po -n $namespace | grep jmeter-master | awk '{print $1}'`

kubectl -n $namespace exec -ti $master_pod bash /jmeter/apache-jmeter-5.0/bin/stoptest.sh
