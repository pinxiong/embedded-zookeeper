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

SERVER=/apache-zookeeper-3.6.3-bin/bin/zkServer.sh
CLIENT=/apache-zookeeper-3.6.3-bin/bin/zkCli.sh

STARTED_2181=`docker-compose ps | grep "dubbo-zookeeper-2181" | wc -l`
STARTED_2182=`docker-compose ps | grep "dubbo-zookeeper-2182" | wc -l`

case $1 in 
start)
    if [ "$STARTED_2181" -eq "1" ] && [ "$STARTED_2182" -eq "1" ]
    then
        echo "The zookeeper instances with port 2181 and 2182 have started successfully!"
        exit 1
    else
        echo "Clean dubbo-zookeeper instances ... "
        docker-compose down -v
        echo "Start zookeeper instances ..."
        docker-compose -f docker-compose.yml up -d --isolation=hyperv
    fi
    ;;
stop)
    echo "stop zookeeper instances"
    docker-compose down -v
    ;;
status)
    echo "zookeeper info with 2181"
    docker-compose exec dubbo-zookeeper-2181 /bin/bash $SERVER status
    echo "zookeeper info with 2181"
    docker-compose exec dubbo-zookeeper-2182 /bin/bash $SERVER status
    ;;
reset)
    echo "reset zookeeper with 2181"
    docker-compose exec dubbo-zookeeper-2181 /bin/bash $CLIENT -timeout 5000  -server 127.0.0.1:2181 deleteall /dubbo quit
    echo "reset zookeeper with 2182"
    docker-compose exec dubbo-zookeeper-2182 /bin/bash $CLIENT -timeout 5000  -server 127.0.0.1:2181 deleteall /dubbo quit
    ;;
*)
    echo "./zkCmd.sh start|stop|status|reset"
    exit 1
    ;;
esac