FROM mysql:5.7

VOLUME /data

ENV MYSQL_ALLOW_EMPTY_PASSWORD=yes \
    MYSQL_DATABASE=cities \
    MYSQL_USER=shipping \
    MYSQL_PASSWORD=secret

# change datadir entry in /etc/mysql/my.cnf
COPY config.sh /root/
COPY config.sh /tmp/
RUN chmod 777 /tmp/config.sh
RUN /tmp/config.sh

COPY scripts/* /docker-entrypoint-initdb.d/

#RUN /entrypoint.sh mysqld & while [ ! -f /tmp/finished ]; do sleep 10; done
#RUN rm /docker-entrypoint-initdb.d/*

#RUN service mysql stop
#RUN usermod -d /var/lib/mysql/ mysql
#RUN service mysql start

COPY datadog /tmp/

RUN reboot

RUN mysql < /tmp/datadog
