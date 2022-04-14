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

RUN apt-get update -y
RUN apt-get install sudo

COPY scripts/* /docker-entrypoint-initdb.d/

#RUN /entrypoint.sh mysqld & while [ ! -f /tmp/finished ]; do sleep 10; done
#RUN rm /docker-entrypoint-initdb.d/*

RUN sudo service mysql stop
RUN sudo usermod -d /var/lib/mysql/ mysql
RUN sudo service mysql start

RUN sleep 30

COPY datadog /tmp/

RUN sudo mysql < /tmp/datadog
