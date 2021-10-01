#!/bin/bash

# Licensed to the Apache Software Foundation (ASF) under one
# or more contributor license agreements.  See the NOTICE file
# distributed with this work for additional information
# regarding copyright ownership.  The ASF licenses this file
# to you under the Apache License, Version 2.0 (the
# "License"); you may not use this file except in compliance
# with the License.  You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

ZOOKEEPER_HOME_2181=/usr/local/zookeeper/2181/apache-zookeeper-3.6.0-2181
ZOOKEEPER_HOME_2182=/usr/local/zookeeper/2182/apache-zookeeper-3.6.0-2182
ZOOKEEPER_SERVER_2181=$ZOOKEEPER_HOME_2181/bin/zkServer.sh
ZOOKEEPER_SERVER_2182=$ZOOKEEPER_HOME_2182/bin/zkServer.sh
ZOOKEEPER_CLIENT_2181=$ZOOKEEPER_HOME_2181/bin/zkCli.sh
ZOOKEEPER_CLIENT_2182=$ZOOKEEPER_HOME_2182/bin/zkCli.sh

case $1 in 
start)
    echo "start zookeeper"
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
    echo "./zookeeper.sh start|restart|stop|status|reset"
    exit 1
    ;;
esac
exit 0