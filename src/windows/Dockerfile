FROM openjdk:17-windowsservercore-ltsc2016

ARG DISTRO_NAME=zookeeper-3.6.3

ADD $DISTRO_NAME.tar.gz 'C:\\'

ADD docker-entrypoint.cmd C:\\docker-entrypoint.cmd

RUN rename C:\\apache-%DISTRO_NAME%-bin zookeeper

ENV ZOO_DATA_DIR=C:\\data \
    ZOO_DATA_LOG_DIR=C:\\datalog \
    ZOO_PORT=2181 \
    ZOO_TICK_TIME=2000 \
    ZOO_INIT_LIMIT=5 \
    ZOO_SYNC_LIMIT=2 \
    ZOO_MY_ID=1


VOLUME ["$ZOO_DATA_DIR", "$ZOO_DATA_LOG_DIR"]

EXPOSE $ZOO_PORT 2888 3888

WORKDIR C:\\zookeeper

ENTRYPOINT C:\\docker-entrypoint.cmd
CMD C:\\zookeeper\\bin\\zkServer.cmd