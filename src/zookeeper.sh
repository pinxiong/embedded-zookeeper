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

# seart docker container before
CONTAINER_ID=`docker container list -a | grep "dubbo-zookeeper" |awk '{print $1}'`
if [ "$CONTAINER_ID" == "" ]; then
    echo "Start dubbo/zookeeper:8 image..."
    docker run --name="dubbo-zookeeper" -d dubbo/zookeeper:8  -p 2181:2181 2182:2182
    CONTAINER_ID=`docker ps | grep "dubbo/zookeeper:8" |awk '{print $1}'`
    if [ "$CONTAINER_ID" == "" ]; then
        echo "ERROR: Failed to start dubbo/zookeeper:8 image, maybe you need to run build-zk-image.sh first"
        return 1
    fi
else
    STARTED_CONTAINER_ID=`docker ps | grep "dubbo/zookeeper:8" |awk '{print $1}'`
    if [ "$STARTED_CONTAINER_ID" == "" ]; then
        docker start $CONTAINER_ID
    fi
fi

ZK_CMD=/usr/local/zookeeper/zkCmd.sh

case $1 in 
start)
    docker exec -it $CONTAINER_ID $ZK_CMD start
    ;;
restart)
    docker exec -it $CONTAINER_ID $ZK_CMD restart
    ;;
stop)
    docker exec -it $CONTAINER_ID $ZK_CMD stop
    docker stop $CONTAINER_ID
    ;;
status)
    docker exec -it $CONTAINER_ID $ZK_CMD status
    ;;
reset)
    docker exec -it $CONTAINER_ID $ZK_CMD reset
    ;;
*)
    echo "./zookeeper.sh start|restart|stop|status|reset"
    exit 1
    ;;
esac
exit 0