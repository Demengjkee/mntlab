# Troubleshooting

\# | Issue | How to find | Time to find | how to fix | Time to fix
--- | --- | --- | --- | --- | ---
1 | Redirect to `http://mntlab/` | `curl -ILv 192.168.56.10` <br/> `less /etc/httpd/conf/httpd.conf` | 20m | Remove wrong vitual host, make vhost from `vhost.conf` handle all requests. | 2h
2 | Mod_jk is not working | `curl -ILv 192.168.56.10` <br/> `less /var/log/httpd/modjk.log` | 10m | Fix worker.properties | 20m
3 | Bad CATALINA_HOME for tomcat | `/etc/init.d/tomcat start` <br/> `less /home/tomcat/.bashrc` | 10m | remove CATALINA_HOME | 10m
4 | bad java vesion installed | `/etc/init.d/tomcat start` <br/> `less logs/catalina.out` | 5m | set proper JAVA_HOME for user tomcat | 5m
5 | Iptables file cannot be edited | Trying to edit iptables <br/> `lsattr /etc/sysconfig/iptables` | 1h 20m | `chattr -i /etc/sysconfig/iptables` | 10m
6 | Iptables cannot be started | start iptables | 5m | Add `ESTABLISHED` to `-A INPUT -m state --state ESTABLISHED,RELATED -j ACCEPT` | 5m
7 | Iptables allow port 80 | `curl -ILv 192.168.56.10` | 10m | `iptables -I INPUT -p tcp --dport 80 -j ACCEPT` <br/> `iptables-save > /etc/sysconfig/iptables` | 20m
8 | Tomcat init script | `/etc/init.d/tomcat start` <br/> `ps aux | grep java` <br/> `less /etc/init.d/tomcat` | 5m | check status code of tomcat startup script | 2h
9 | tomcat works on 192.168.56.10 instead of localhost | `netstat -tulpn` | 15m | replace 192.168.56.10 to localhost in `/opt/apache/tomcat/current/conf/server.xml` and `/etc/httpd/conf.d/workers.properties` | 10m
10 | create link for tomcat logs in `/var/log/` | | | `ln -s /opt/apache/tomcat/current/logs/ /var/log/tomcat` | 5m | 

* What java version is installed? `1.7.0_79`
* How was it installed and configured? downloaded and unpacked archive from oracle website , then configured `java` via `alternatives --config java`
* Where are log files of tomcat and httpd? `/var/log/httpd` and `$CATALINA_HOME/logs/` 
* Where is JAVA_HOME and what is it? `/usr/`(configured by alternatives) or `/opt/oracle/java/x64/jdk1.7.0_79`; `JAVA_HOME` is dir where `bin/java`located
* Where is tomcat installed? `/opt/apache/tomcat/current`
* What is CATALINA_HOME? dir where tomcat files are located (i.e. `/opt/apache/tomcat/current`) 
* What users run httpd and tomcat processes? How is it configured? __root__(httpd master) __apache__(httpd slaves) and __tomcat__, run command with `su - <user> -c "<command>"` or `sudo -u <user> <command>`
* What configuration files are used to make components work with each other? `worker.properties`; `vhost.conf`
* What does it mean: “load average: 1.18, 0.95, 0.83”? System load averages is the average number of processes that are either in a runnable or uninterruptable state. Each process witch is __ready for execution__ or __executing__ and also processes in suck states as __waiting for disk__ adds 1 to load
