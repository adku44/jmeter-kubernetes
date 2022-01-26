#!/usr/bin/env bash
# This script reads '.jmx' file with test scenario, copy it to jmeter master POD
# and finally execute it on the master
#
# January 26, 2022
# by adku44


working_dir="`pwd`"

# Read namesapce 
namespace=`awk '{print $NF}' "$working_dir/namespace-for-k8s"`

jmx="$1"
[ -n "$jmx" ] || read -p 'Enter path to the jmx file ' jmx

if [ ! -f "$jmx" ];
then
    echo "Test script file does not exist or not found"
    exit
fi

# Filter only file name from the path
file_name="$(basename "$jmx")"

# Get master POD name
master_pod=`kubectl get po -n $namespace | grep jmeter-master | awk '{print $1}'`

# Copy file with test scenario into master POD
kubectl cp "$jmx" -n $namespace "$master_pod:/$file_name"

# Strat load tests
kubectl exec -ti -n $namespace $master_pod -- /bin/bash /load_test "$file_name"
