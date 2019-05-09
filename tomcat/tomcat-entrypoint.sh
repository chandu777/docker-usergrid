#!/bin/bash
USERGRID_PROPERTIES_FILE=/tomcat/lib/usergrid-deployment.properties

sed -i "s/cassandra.url=xxxx/cassandra.url=${CASSANDRA_URL}/g" $USERGRID_PROPERTIES_FILE
sed -i "s/elasticsearch.hosts=xxxx/elasticsearch.hosts=${ELASTICSEARCH_HOST}/g" $USERGRID_PROPERTIES_FILE

exec "$@"
