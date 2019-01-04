#create projects
oc new-project tasks-build
oc new-project tasks-dev
oc new-project tasks-test
oc new-project tasks-prod

#create jenkins
oc new-app jenkins-persistent -n tasks-build

#create tasks image stream
oc create is openshift-tasks -n openshift

#setup tasks app in projects
oc create -f appdev/tasks-build.yaml -n tasks-build
oc process -f appdev/tasks.yaml -p VERSION=dev -n tasks-dev | oc create -f - -n tasks-dev
oc process -f appdev/tasks.yaml -p VERSION=test -n tasks-test | oc create -f - -n tasks-test
oc process -f appdev/tasks.yaml -p VERSION=prod -n tasks-prod | oc create -f - -n tasks-prod

#give jenkins edit permissions in all tasks projects
oc policy add-role-to-user edit system:serviceaccount:tasks-build:jenkins -n tasks-build
oc policy add-role-to-user edit system:serviceaccount:tasks-build:jenkins -n tasks-dev
oc policy add-role-to-user edit system:serviceaccount:tasks-build:jenkins -n tasks-test
oc policy add-role-to-user edit system:serviceaccount:tasks-build:jenkins -n tasks-prod
oc policy add-role-to-user edit system:serviceaccount:tasks-build:jenkins -n openshift

#give projects image pull permissions on openshift project
oc policy add-role-to-user image-builder system:serviceaccount:tasks-build:jenkins -n openshift
oc policy add-role-to-user image-builder system:serviceaccount:tasks-build:builder -n openshift
oc policy add-role-to-user edit system:serviceaccount:tasks-build:builder -n openshift
oc policy add-role-to-user system:image-puller system:serviceaccount:tasks-dev:deployer -n openshift
oc policy add-role-to-user system:image-puller system:serviceaccount:tasks-test:deployer -n openshift
oc policy add-role-to-user system:image-puller system:serviceaccount:tasks-prod:deployer -n openshift

#create and start pipeline
oc create -f appdev/tasks-pipeline.yaml -n tasks-build
sleep 60
oc start-build tasks-pipeline -n tasks-build
