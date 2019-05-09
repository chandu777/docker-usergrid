# docker file for usergrid deployed in tomcat

FROM yep1/usergrid-java

MAINTAINER chandrakant

WORKDIR /root
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle

RUN \
  sed -i'' 's/archive\.ubuntu\.com/\old-releases\.ubuntu\.com/' /etc/apt/sources.list && \
  echo "+++ install tomcat and packages required for compilation" && \ 
  apt-get update && \
  apt-get install -y maven curl supervisor openssh-server git-core && \
  mkdir -p /var/log/supervisor && \
  mkdir -p /var/run/sshd && \
  \
# get usergrid from git and make build && \
  git clone --single-branch --branch master https://github.com/apache/usergrid.git usergrid && \
  cd usergrid/sdks && \
  rm -rf java && \
  git clone https://github.com/apache/usergrid-java.git && \
  mv usergrid-java java && \
  cd java && \
  mvn clean install -DskipTests && \
  cd ../../stack/ && \
  mvn clean install -DskipTests && \
  cp rest/target/ROOT.war /root/ && \
  rm -rf /root/usergrid && \
  \
# add pwd to file
  echo 'root:root' | chpasswd && \
  sed -i 's/PermitRootLogin prohibit-password/PermitRootLogin yes/' /etc/ssh/sshd_config && \
# SSH login fix. Otherwise user is kicked off after login
  sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd

ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

RUN \
  cd / && \
  wget https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.85/bin/apache-tomcat-7.0.85.tar.gz && \
  tar xvzf apache-tomcat-7.0.85.tar.gz && \
  rm -f apache-tomcat-7.0.85.tar.gz && \
  mv /apache-tomcat-7.0.85 /tomcat && \
  rm -rf /tomcat/webapps/* && \
  cp /root/ROOT.war /tomcat/webapps/

COPY tomcat-entrypoint.sh /root/tomcat-entrypoint.sh
COPY usergrid-deployment.properties /tomcat/lib/
COPY user-creation-script.sh /root/user-creation-script.sh
RUN chmod 377 /root/user-creation-script.sh /root/user-creation-script.sh /tomcat/lib/usergrid-deployment.properties
COPY supervisord.conf /etc/supervisor/conf.d/supervisord.conf

ENTRYPOINT ["/root/tomcat-entrypoint.sh"]
CMD ["/usr/bin/supervisord"]

# exposed ports:
#  8080 usergrid http interface
#  8443 usergrid https interface
EXPOSE 8080 8443 22

