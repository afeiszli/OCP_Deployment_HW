#!/bin/bash

#Create Users
htpasswd -b /etc/origin/master/htpasswd amy r3dh4t1!
htpasswd -b /etc/origin/master/htpasswd andrew r3dh4t1!
htpasswd -b /etc/origin/master/htpasswd brian r3dh4t1!
htpasswd -b /etc/origin/master/htpasswd betty r3dh4t1!

oc login -u amy -p r3dh4t1!
oc login -u andrew -p r3dh4t1!
oc login -u brian -p r3dh4t1!
oc login -u betty -p r3dh4t1!
oc login -u system:admin

#label users for corp
oc label user/amy level=AlphaCorp
oc label user/andrew level=AlphaCorp
oc label user/brian level=BetaCorp
oc label user/betty level=BetaCorp

oc adm groups new alpha amy andrew | true
oc adm groups new alpha brian betty | true
