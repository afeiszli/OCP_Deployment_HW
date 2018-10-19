#!/usr/bin/env bash

echo "Copy a new hosts file to /etc/ansible/hosts"
cp /root/OCP_Deployment_HW/hosts /etc/ansible/hosts

echo "Set the current GUID to generate the inventory"
GUID=`hostname|awk -F. '{print $2}'`
sed -i "s/GUID/$GUID/g" /etc/ansible/hosts
