#!/bin/bash

#Make sure GUID is set
export GUID=`hostname | cut -d"." -f2`; echo "export GUID=$GUID"

#label nodes
oc label node node1.$GUID.internal client=alpha
oc label node node2.$GUID.internal client=beta
oc label node node3.$GUID.internal client=common

#create namespace alpha
oc new-project alpha
oc patch namespace alpha -p '{"metadata":{"annotations":{"openshift.io/node-selector":"client=alpha"}}}'
oc label namespace alpha client=alpha
oc adm policy add-role-to-group edit alpha -n alpha

#create namespace beta
oc new-project beta
oc patch namespace beta -p '{"metadata":{"annotations":{"openshift.io/node-selector":"client=beta"}}}'
oc label namespace beta client=beta
oc adm policy add-role-to-group edit beta -n beta

