#!/bin/bash

#Create Users
htpasswd -c -b /etc/origin/maser/htpasswd amy r3dh4t1!
htpasswd -c -b /etc/origin/maser/htpasswd andrew r3dh4t1!
htpasswd -c -b /etc/origin/maser/htpasswd brian r3dh4t1!
htpasswd -c -b /etc/origin/maser/htpasswd betty r3dh4t1!

#label users for corp
oc label user/amy level=AlphaCorp
oc label user/andrew level=AlphaCorp
oc label user/brian level=BetaCorp
oc label user/betty level=BetaCorp
