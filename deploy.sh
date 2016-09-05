MYSQL_USER=username
MYSQL_PASSWORD=password
MYSQL_DATABASE=database

set -e

oc delete all --all

oc process -f template.yaml DATABASE_NAME=$MYSQL_DATABASE \
   DATABASE_PASSWORD=$MYSQL_PASSWORD \
   DATABASE_USER=$MYSQL_USER |oc create -f-

oc deploy --latest mysql
oc logs -f dc/mysql
sleep 5
oc logs dc/mysql
