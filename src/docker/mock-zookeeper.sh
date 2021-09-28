#!/bin/bash

ZOOKEEPER_HOME_2181=/usr/local/zookeeper/2181/apache-zookeeper-3.6.0-2181
ZOOKEEPER_HOME_2182=/usr/local/zookeeper/2182/apache-zookeeper-3.6.0-2182
ZOOKEEPER_SERVER_2181=$ZOOKEEPER_HOME_2181/bin/zkServer.sh
ZOOKEEPER_SERVER_2182=$ZOOKEEPER_HOME_2182/bin/zkServer.sh
ZOOKEEPER_CLIENT_2181=$ZOOKEEPER_HOME_2181/bin/zkCli.sh
ZOOKEEPER_CLIENT_2182=$ZOOKEEPER_HOME_2182/bin/zkCli.sh

case $1 in 
start)
    echo "start zookeeper"
    ./init.sh
    $ZOOKEEPER_SERVER_2181 start
    $ZOOKEEPER_SERVER_2182 start
    ;;
stop)
    echo "stop zookeeper"
    if [ ! -f "$ZOOKEEPER_SERVER_2181" ]; then
        echo "ERROR: please start zookeeper before"
        return 1
    fi
    $ZOOKEEPER_SERVER_2181 stop
    if [ ! -f "$ZOOKEEPER_SERVER_2182" ]; then
        echo "ERROR: please start zookeeper before"
        return 1
    fi
    $ZOOKEEPER_SERVER_2182 stop
    ;;
status)
    echo "zookeeper info"
    if [ ! -f "$ZOOKEEPER_SERVER_2181" ]; then
        echo "ERROR: please start zookeeper before"
        return 1
    fi
    $ZOOKEEPER_SERVER_2181 status
    if [ ! -f "$ZOOKEEPER_SERVER_2182" ]; then
        echo "ERROR: please start zookeeper before"
        return 1
    fi
    $ZOOKEEPER_SERVER_2182 status
    ;;
reset)
    echo "reset zookeeper"
    if [ ! -f "$ZOOKEEPER_CLIENT_2181" ]; then
        echo "ERROR: please start zookeeper before"
        return 1
    fi
    $ZOOKEEPER_CLIENT_2181 -timeout 5000  -server 127.0.0.1:2181 deleteall /dubbo quit
    if [ ! -f "$ZOOKEEPER_CLIENT_2182" ]; then
        echo "ERROR: please start zookeeper before"
        return 1
    fi
    $ZOOKEEPER_CLIENT_2182 -timeout 5000  -server 127.0.0.1:2182 deleteall /dubbo quit
    ;;
*)
    echo "./mock-zookeeper.sh start|stop|status|reset"
    exit 1
    ;;
esac
exit 0