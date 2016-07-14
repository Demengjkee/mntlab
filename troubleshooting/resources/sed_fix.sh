#!/bin/bash


sed -i '/^<VirtualHost.*>/,/^<\/VirtualHost>/{s/^/#/}' /etc/httpd/conf/httpd.conf
sed -i 's/mntlab/\*/g' /etc/httpd/conf.d/vhost.conf
sed -i -e 's/worker-jk@ppname/tomcat\.worker/g' -e 's/192\.168\.56\.100/127\.0\.0\.1/g' /etc/httpd/conf.d/workers.properties
apachectl restart

chown tomcat:tomcat /opt/apache/tomcat/current/logs/
ln -s /opt/oracle/java/x64/jdk1.7.0_79 /opt/oracle/java/current
sed -i -e 's/\(JAVA_HOME=\)\(.*\)/\1\/opt\/oracle\/java\/current/' -e '/CATALINA_HOME/d' /home/tomcat/.bashrc

chattr -i /etc/sysconfig/iptables
grep "RELATED,ESTABLISHED" /etc/sysconfig/iptables > /dev/null
if [ $? -eq 1 ]; then
	sed -i 's/\(.*\)\(RELATED\)\(.*\)/\1\2,ESTABLISHED\3/' /etc/sysconfig/iptables
fi
grep ' --dport 80 ' /etc/sysconfig/iptables
if [ $? -eq 1 ]; then 
	sed -i '$i-A INPUT -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT' /etc/sysconfig/iptables
fi
sed -i 's/192\.168\.56\.10/127\.0\.0\.1/g' /opt/apache/tomcat/current/conf/server.xml
cp -f /vagrant/resources/tomcat /etc/init.d/
chkconfig tomcat on
/etc/init.d/tomcat start

ln -s /opt/apache/tomcat/current/logs/ /var/log/tomcat

