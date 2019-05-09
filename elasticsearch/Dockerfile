# Elasticsearch Dockerfile for Usergrid

FROM yep1/usergrid-java

MAINTAINER chandrakant

ENV ES_PKG_NAME elasticsearch-1.7.6
ENV CONFIG_FILE=/elasticsearch/config/elasticsearch.yml

WORKDIR /root

# install elasticsearch
RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch
  #sed -i -e "s/#cluster.name: elasticsearch/cluster.name: $ES_CLUSTER_NAME/" $CONFIG_FILE

RUN sed -i'' 's/archive\.ubuntu\.com/\old-releases\.ubuntu\.com/' /etc/apt/sources.list
RUN apt-get update && apt-get install -y supervisor
RUN mkdir -p /var/log/supervisor
COPY entrypoint-elasticsearch.sh /root/entrypoint-elasticsearch.sh
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT ["/root/entrypoint-elasticsearch.sh"]
CMD ["/usr/bin/supervisord"]

# define mountable directories
VOLUME ["/data"]

# expose ports
#   - 9200: HTTP
#   - 9300: native transport
EXPOSE 9200
EXPOSE 9300


