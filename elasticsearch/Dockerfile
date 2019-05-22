# Elasticsearch Dockerfile for Usergrid

FROM ca03430/ubuntu18:java

MAINTAINER chandrakant

RUN groupadd -r elasticsearch --gid=999 && useradd -r -g elasticsearch --uid=999 elasticsearch

ENV ES_PKG_NAME elasticsearch-1.7.6
ENV CONFIG_FILE=/elasticsearch/config/elasticsearch.yml

WORKDIR /root

#RUN sed -i'' 's/archive\.ubuntu\.com/\old-releases\.ubuntu\.com/' /etc/apt/sources.list
RUN apt-get update && apt-get install -y supervisor wget curl
RUN mkdir -p /var/log/supervisor

# install elasticsearch
RUN \
  cd / && \
  wget https://download.elasticsearch.org/elasticsearch/elasticsearch/$ES_PKG_NAME.tar.gz && \
  tar xvzf $ES_PKG_NAME.tar.gz && \
  rm -f $ES_PKG_NAME.tar.gz && \
  mv /$ES_PKG_NAME /elasticsearch
  #sed -i -e "s/#cluster.name: elasticsearch/cluster.name: $ES_CLUSTER_NAME/" $CONFIG_FILE
RUN chown -R elasticsearch:elasticsearch /elasticsearch \
    && chmod 777 /elasticsearch

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


