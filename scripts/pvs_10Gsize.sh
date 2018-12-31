#!/usr/bin/env bash

export GUID=`hostname|awk -F. '{print $2}'`
export volsize="10Gi"

for i in pv{26..50} ; do
  oc process -f ./pv-template.yaml -p HOST=${GUID} VOLUME_NAME=${i} VOLSIZE=${volsize} | oc create -f -
done
