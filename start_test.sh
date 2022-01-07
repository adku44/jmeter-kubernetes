#!/usr/bin/env bash
#Script created to launch Jmeter tests directly from the current terminal without accessing the jmeter master pod.
#It requires that you supply the path to the jmx file
#After execution, test script jmx file may be deleted from the pod itself but not locally.

working_dir="`pwd`"

#Get namesapce variable
namespace=`awk '{print $NF}' "$working_dir/namespace-for-k8s"`

jmx="$1"
[ -n "$jmx" ] || read -p 'Enter path to the jmx file ' jmx

if [ ! -f "$jmx" ];
then
    echo "Test script file was not found in PATH"
    echo "Kindly check and input the correct file path"
    exit
fi

test_name="$(basename "$jmx")"

#Get Master pod details

master_pod=`kubectl get po -n $namespace | grep jmeter-master | awk '{print $1}'`

kubectl cp "$jmx" -n $namespace "$master_pod:/$test_name"

## Echo Starting Jmeter load test

kubectl exec -ti -n $namespace $master_pod -- /bin/bash /load_test "$test_name"
