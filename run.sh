#!/bin/bash
## The below while condition is used for when two init containers will not run parallel so code run smooth.
while true ; do
  if [ -f /data/params ]; then
    source /data/params
    break
  else
    sleep 5
  fi
done

mkdir /app
cd    /app
git clone https://github.com/siva-devops73/${COMPONENT}
cd  ${COMPONENT}/schema


if [ "${SCEHMA_TYPE}" == "mongo" ]; then
  curl -s -L https://truststore.pki.rds.amazonaws.com/global/global-bundle.pem -o /app/rds-combined-ca-bundle.pem
  mongo --ssl --host ${DOCDB_ENDPOINT}:27017 --sslCAFile /app/rds-combined-ca-bundle.pem --username ${DOCDB_USERNAME} --password ${DOCDB_PASSWORD} <${COMPONENT}.js
elif [ "${SCEHMA_TYPE}" == "mysql" ]; then
  echo show databases | mysql -h ${MYSQL_ENDPOINT} -u${MYSQL_USERNAME} -p${MYSQL_PASSWORD} | grep cities
  if [ $? -ne 0 ]; then
    mysql -h ${MYSQL_ENDPOINT} -u${MYSQL_USERNAME} -p${MYSQL_PASSWORD} <${COMPONENT}.sql
  fi
else
  echo Invalid Schema Input
  exist 1
fi