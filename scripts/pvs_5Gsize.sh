#!/usr/bin/env bash

export GUID=`hostname|awk -F. '{print $2}'`
export volsize="5Gi"

for i in pv{1..25} ; do
  oc process -f ../pv-template.yaml -p HOST=${GUID} VOLUME_NAME=${i} VOLSIZE=${volsize} | oc create -f -
done

