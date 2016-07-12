#!/bin/bash

chattr -i /etc/sysconfig/iptables

iptables-restore < /vagrant/resources/iptables
iptables-save > /etc/sysconfig/iptables

echo "JAVA_HOME=/opt/oracle/java/x64/jdk1.7.0_79" > /opt/apache/tomcat/current/bin/setenv.sh
chown -R tomcat:tomcat /opt/apache/tomcat/
cp -f /vagrant/resources/tomcat /etc/init.d/
echo > /home/tomcat/.bashrc
chkconfig tomcat on
/etc/init.d/tomcat start

cp -f /vagrant/resources/workers.properties /etc/httpd/conf.d/
cp -f /vagrant/resources/vhost.conf /etc/httpd/conf.d/
cp -f /vagrant/resources/httpd.conf /etc/httpd/conf/
apachectl restart
