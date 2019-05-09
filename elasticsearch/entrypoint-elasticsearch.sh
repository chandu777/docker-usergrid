#!/bin/bash

CONFIG_FILE=/elasticsearch/config/elasticsearch.yml

sed -i -e "s/#cluster.name: elasticsearch/cluster.name: ${ES_CLUSTER_NAME}/" ${CONFIG_FILE}
exec "$@"
