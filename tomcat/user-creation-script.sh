#!/bin/bash

while [ -z "$(curl -s localhost:8080/status | grep '"cassandraAvailable" : true')" ] ;
do
  echo "+++ tomcat log:"
  tail -n 20 /tomcat/logs/catalina.out
  echo "+++ waiting for cassandra being available to usergrid"
  sleep 2
done

if [ -z "$(curl -i -su superuser:abc123 0:8080/management/orgs | grep 'HTTP/1.1 200 OK')" ] ;
then
echo "+++ usergrid database setup"
curl --user superuser:abc123 -X PUT http://localhost:8080/system/database/setup
sleep 10
echo "+++ usergrid database bootstrap"
curl --user superuser:abc123 -X PUT http://localhost:8080/system/database/bootstrap
sleep 10
echo "+++ usergrid superuser setup"
curl --user superuser:abc123 -X GET http://localhost:8080/system/superuser/setup
fi
