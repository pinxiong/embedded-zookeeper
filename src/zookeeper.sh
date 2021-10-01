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

CONTAINER_ID=`docker ps | grep "dubbo/zookeeper:8" |awk '{print $1}'`
if [ "$CONTAINER_ID" == "" ]; then
  echo "Please run build-zk-image.sh first"
  return 1
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
    docker container rm --force $CONTAINER_ID
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