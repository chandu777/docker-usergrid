# docker file for usergrid cassandra
FROM yep1/usergrid-java

MAINTAINER chandrakant

ENV CASSANDRA_CONFIG /etc/cassandra

RUN groupadd -r cassandra --gid=999 && useradd -r -g cassandra --uid=999 cassandra

RUN \
  cd /etc && \
  wget https://www.apache.org/dist/cassandra/2.1.21/apache-cassandra-2.1.21-bin.tar.gz && \
  tar xvzf apache-cassandra-2.1.21-bin.tar.gz && \
  rm -f apache-cassandra-2.1.21-bin.tar.gz && \
  mv /etc/apache-cassandra-2.1.21 /etc/cassandra

RUN sed -i'' 's/archive\.ubuntu\.com/\old-releases\.ubuntu\.com/' /etc/apt/sources.list
RUN \
  echo "+++ install python" && \
  apt-get update && \
  apt-get install -y python supervisor

COPY docker-entrypoint.sh /usr/local/bin/
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf
RUN ln -s usr/local/bin/docker-entrypoint.sh /docker-entrypoint.sh # backwards compat

RUN mkdir -p /var/lib/cassandra "$CASSANDRA_CONFIG" /var/log/cassandra /var/log/supervisor

RUN chown -R cassandra:cassandra /var/lib/cassandra "$CASSANDRA_CONFIG" \
    && chmod 777 /var/lib/cassandra "$CASSANDRA_CONFIG"

VOLUME /var/lib/cassandra

ENTRYPOINT ["/usr/local/bin/docker-entrypoint.sh"]
CMD ["/usr/bin/supervisord"]

# 7000: intra-node communication
# 7001: TLS intra-node communication
# 7199: JMX
# 9042: CQL
# 9160: thrift service
EXPOSE 7000 7001 7199 9042 9160
