#!/bin/bash

oc label node node1.$GUID.internal client=alpha
oc label node node2.$GUID.internal client=beta
oc label node node3.$GUID.internal client=common

