#!/bin/bash

chattr -i /etc/sysconfig/iptables

iptables-restore < /vagrant/resources/iptables
iptables-save > /etc/sysconfig/iptables

cp -f /vagrant/resources/workers.properties /etc/httpd/conf.d/
cp -f /vagrant/resources/vhost.conf /etc/httpd/conf.d/
cp -f /vagrant/resources/httpd.conf /etc/httpd/conf/
apachectl restart

chown tomcat:tomcat /opt/apache/tomcat/current/logs/
cp -f /vagrant/resources/tomcat /etc/init.d/
cp -f /vagrant/resources/.bashrc /home/tomcat/
cp -f /vagrant/resources/server.xml /opt/apache/tomcat/current/conf/
chkconfig tomcat on
/etc/init.d/tomcat start

ln -s /opt/apache/tomcat/current/logs/ /var/log/tomcat