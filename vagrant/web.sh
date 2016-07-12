#!/bin/bash 

sudo yum install -y make gcc gcc-c++

yum install -y httpd httpd-devel

wget http://archive.apache.org/dist/jakarta/tomcat-connectors/jk/source/jk-1.2.15/jakarta-tomcat-connectors-1.2.15-src.tar.gz \
&& tar xvzf jakarta-tomcat-connectors-1.2.15-src.tar.gz \
&& cd jakarta-tomcat-connectors-1.2.15-src/jk/native \
&& ./buildconf.sh \
&& ./configure --with-apxs=/usr/sbin/apxs && make && make install \
&& rm -rf /jakarta-tomcat-connectors-1.2.15-src.tar.gz \
&& rm -rf /jakarta-tomcat-connectors-1.2.15-src

cp /mnt/share/*.conf /etc/httpd/conf.d/
cp /mnt/share/*.properties /etc/httpd/conf.d/

