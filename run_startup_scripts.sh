#!/bin/bash

exec nohup java -jar /var/www/html/vta-oar.jar > /var/log/vta-oar.log &
exec nohup java -jar /var/www/html/vta-vas.jar > /var/log/vta-vas.log &
exec nohup java -jar /var/www/html/vta-autokit.jar > /var/log/vta-autokit.log &
/bin/sh /usr/local/tomcat/bin/startup.sh
a2enconf servername
service apache2 reload
exec /usr/sbin/apache2ctl -D FOREGROUND
