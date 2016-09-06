#!/bin/bash
oc delete job backup

oc create -f job-backup.yaml

i=0
while [[ $i != 10 ]];do
    oc get pod -l name=backup --show-labels=false|grep -q Completed || sleep 5 && break
    $i++
done

oc logs -f $(oc get pod -o name -l name=backup)
