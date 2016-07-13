#!/bin/bash


sed -i '/^<VirtualHost.*>/,/^<\/VirtualHost>/{s/^/#/}' /etc/httpd/conf/httpd.conf
sed -i 's/mntlab/\*/g' /etc/httpd/conf.d/vhost.conf
sed -i -e 's/worker-jk@ppname/tomcat\.worker/g' -e 's/192\.168\.56\.100/localhost/g' /etc/httpd/conf.d/workers.properties
apachectl restart

chown tomcat:tomcat /opt/apache/tomcat/current/logs/
sed -i -e 's/\(JAVA_HOME=\)\(.*\)/\1\/opt\/oracle\/java\/x64\/jdk1\.7\.0_79/' -e '/CATALINA_HOME/d' /home/tomcat/.bashrc

chattr -i /etc/sysconfig/iptables
sed -i 's/\(.*\)\(RELATED\)\(.*\)/\1RELATED,ESTABLISHED\3/' /etc/sysconfig/iptables
sed -i '/\(.*\)\(RELATED\)\(.*\)/a -A INPUT -p tcp -m tcp --dport 80 -j ACCEPT' /etc/sysconfig/iptables

sed -i 's/192\.168\.56\.10/localhost/g' /opt/apache/tomcat/current/conf/server.xml
chkconfig tomcat on
/etc/init.d/tomcat start

ln -s /opt/apache/tomcat/current/logs/ /var/log/tomcat

