#!/bin/bash

#Create Users
htpasswd -b /etc/origin/master/htpasswd amy r3dh4t1!
htpasswd -b /etc/origin/master/htpasswd andrew r3dh4t1!
htpasswd -b /etc/origin/master/htpasswd brian r3dh4t1!
htpasswd -b /etc/origin/master/htpasswd betty r3dh4t1!

#label users for corp
oc label user/amy level=AlphaCorp
oc label user/andrew level=AlphaCorp
oc label user/brian level=BetaCorp
oc label user/betty level=BetaCorp
