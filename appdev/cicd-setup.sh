
oc process -f appdev/project.yaml -p PROJECT_NAME=tasks-build | oc create -f -
oc process -f appdev/project.yaml -p PROJECT_NAME=tasks-dev | oc create -f -
oc process -f appdev/project.yaml -p PROJECT_NAME=tasks-qa | oc create -f -
oc process -f appdev/project.yaml -p PROJECT_NAME=tasks-prod | oc create -f -

oc new-app jenkins-persistent -n tasks-dev
oc create is openshift-tasks -n openshift
oc create -f appdev/tasks-build.yaml -n tasks-build
oc process -f appdev/tasks.yaml -n tasks-dev | oc create -f -
oc process -f appdev/tasks.yaml -n tasks-test | oc create -f -
oc process -f appdev/tasks.yaml -n tasks-prod | oc create -f -
oc process -f appdev/tasks-pipeline.yaml -n cicd-dev | oc create -f -


#oc new-app https://github.com/wkulhanek/openshift-tasks.git --name=openshift-task -n cicd
#oc new-app eap70-basic-s2i --param SOURCE_REPOSITORY_URL=https://github.com/wkulhanek/openshift-tasks.git --param APPLICATION_NAME=openshift-tasks -n tasks


oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n tasks-build
oc policy add-role-to-group system:image-puller system:serviceaccounts:cicd -n tasks-build
oc policy add-role-to-user edit system:serviceaccount:cicd:jenkins -n tasks-qa
oc policy add-role-to-group system:image-puller system:serviceaccounts:cicd -n tasks-qa
oc policy add-role-to-group system:image-puller system:serviceaccounts:qa -n tasks-build
oc create deploymentconfig tasks --image=docker-registry.default.svc.cluster.local:5000/tasks/tasks:promoteToQA -n qa
oc expose dc tasks --port=8080 -n qa
oc expose svc tasks  -n qa

oc create -f /opt/Openshft_homework/scripts/sample-pipeline -n cicd
oc start-build sample-pipeline -n cicd
