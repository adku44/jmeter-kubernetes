#!/usr/bin/env bash
# This script is used to stop a running tests on master POD
# It's necessary to run the script when the execution hangs 
# because of a huge number of requests sent by slaves PODs
#
# January 26, 2022
# by adku44

working_dir=`pwd`

# Read namesapce 
namespace=`awk '{print $NF}' $working_dir/namespace-for-k8s`

# Get master POD name
master_pod=`kubectl get po -n $namespace | grep jmeter-master | awk '{print $1}'`

# Execute stop script
kubectl -n $namespace exec -ti $master_pod -- /bin/bash /jmeter/apache-jmeter-5.0/bin/stoptest.sh

echo  "Stop test script initiated on master POD"
