MYSQL_USER=username
MYSQL_PASSWORD=password
MYSQL_DATABASE=database

set -e

for i in configmaps all;do oc delete ${i} --all;done

oc process -f template.yaml DATABASE_NAME=$MYSQL_DATABASE \
   DATABASE_PASSWORD=$MYSQL_PASSWORD \
   DATABASE_USER=$MYSQL_USER |oc create -f-

oc deploy --latest mysql
oc logs -f dc/mysql
sleep 5
oc logs dc/mysql
