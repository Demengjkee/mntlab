#!/bin/bash 

wget --no-cookies --no-check-certificate --header "Cookie: gpw_e25=http%3A%2F%2Fwww.oracle.com%2F; oraclelicense=accept-securebackup-cookie" "http://download.oracle.com/otn-pub/java/jdk/8u91-b14/jdk-8u91-linux-x64.tar.gz" \
&& mkdir /opt/oracle/ \
&& tar xvfz jdk-8u91-linux-x64.tar.gz -C /opt/oracle/ \
&& ln -s /opt/oracle/jdk1.8.0_91/ /opt/oracle/current \
&& rm -f /jdk-8u91-linux-x64.tar.gz

cd /opt && wget http://ftp.byfly.by/pub/apache.org/tomcat/tomcat-8/v8.0.36/bin/apache-tomcat-8.0.36.tar.gz \
&& tar xzf apache-tomcat-8.0.36.tar.gz \
&& rm -rf apache-tomcat-8.0.36.tar.gz \
&& cp -f /mnt/share/server.xml /opt/apache-tomcat-8.0.36/conf/server.xml \
&& echo "JAVA_HOME=/opt/oracle/current" >  /opt/apache-tomcat-8.0.36/bin/setenv.sh \
&& chmod +x /opt/apache-tomcat-8.0.36/bin/*.sh

