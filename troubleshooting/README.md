# Troubleshooting

\# | Issue | How to find | Time to find | how to fix | Time to fix
--- | --- | --- | --- | --- | ---
1 | Iptables cannot be started | Restart iptables | 5m | Add ESTABLISHED to -A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT | 5m
2 | Iptables file cannot be edited | Trying to edit iptables lsattr /etc/sysconfig/iptables | 1h 20m | chattr -i /etc/sysconfig/iptables | 10m
3 | Iptables allow port 80 | curl -ILv 192.168.56.10 | 10m | iptables -I INPUT -p tcp --dport 80 -j ACCEPT <br/> iptables-save > /etc/sysconfig/iptables | 20m
4 | No JAVA_HOME for tomcat | bin/catalina.sh start <br/> cat logs/catalina.out | 5m | echo "JAVA_HOME=/opt/oracle/java/x64/jdk1.7.0_79" > /opt/apache/tomcat/current/bin/setenv.sh | 5m
5 | Mod_jk is not working | curl -v 192.168.56.10 <br/> cat /var/log/httpd/modjk.log | 10m | Fix worker.properties | 20m
6 | Redirect to http://mntlab/ which is unresolved And vhost configured for this address | curl -ILv 192.168.56.10 <br/> cat /etc/httpd/conf/httpd.conf \| grep Redirect | 20m | Remove redirect, make vhost from vhost.conf handle requests. | 2h
7 | Tomcat init script | /etc/init.d/tomcat start <br/> ps aux \| grep java <br/> cat /etc/init.d/tomcat | 5m | Extra / in path for exec files. JAVA_HOME and CATALINA_HOME in .bashrc of tomcat user | 2h

