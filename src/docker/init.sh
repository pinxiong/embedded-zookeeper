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

DIR=/usr/local/zookeeper/
if [ ! -d $DIR ];then
  mkdir -p $DIR
fi

cd $DIR

LOG_DIR=/usr/local/zookeeper/logs
if [ ! -d $LOG_DIR ];then
  mkdir -p $LOG_DIR
  mkdir -p $LOG_DIR/2181
  mkdir -p $LOG_DIR/2182
fi

ZOOKEEPER_DIR_2181=/usr/local/zookeeper/2181
if [ ! -d $ZOOKEEPER_DIR_2181 ];then
  mkdir -p $ZOOKEEPER_DIR_2181
fi

ZOOKEEPER_DIR_2182=/usr/local/zookeeper/2182
if [ ! -d $ZOOKEEPER_DIR_2182 ];then
  mkdir -p $ZOOKEEPER_DIR_2182
fi

# download zookeeper
wget -O apache-zookeeper.tar.gz -c -N --show-progress  https://archive.apache.org/dist/zookeeper/zookeeper-3.6.0/apache-zookeeper-3.6.0-bin.tar.gz

# install with 2181
tar -zxvf apache-zookeeper.tar.gz -C $ZOOKEEPER_DIR_2181
mv $ZOOKEEPER_DIR_2181/apache-zookeeper-3.6.0-bin $ZOOKEEPER_DIR_2181/apache-zookeeper-3.6.0-2181
cp $ZOOKEEPER_DIR_2181/apache-zookeeper-3.6.0-2181/conf/zoo_sample.cfg $ZOOKEEPER_DIR_2181/apache-zookeeper-3.6.0-2181/conf/zoo.cfg
sed -i "s#^dataDir=.*#dataDir=$LOG_DIR/2181#g" $ZOOKEEPER_DIR_2181/apache-zookeeper-3.6.0-2181/conf/zoo.cfg
echo "admin.serverPort=8081" >> $ZOOKEEPER_DIR_2181/apache-zookeeper-3.6.0-2181/conf/zoo.cfg

# install with 2182
tar -zxvf apache-zookeeper.tar.gz -C $ZOOKEEPER_DIR_2182
mv $ZOOKEEPER_DIR_2182/apache-zookeeper-3.6.0-bin $ZOOKEEPER_DIR_2182/apache-zookeeper-3.6.0-2182
cp $ZOOKEEPER_DIR_2182/apache-zookeeper-3.6.0-2182/conf/zoo_sample.cfg $ZOOKEEPER_DIR_2182/apache-zookeeper-3.6.0-2182/conf/zoo.cfg
sed -i "s#^dataDir=.*#dataDir=$LOG_DIR/2182#g" $ZOOKEEPER_DIR_2182/apache-zookeeper-3.6.0-2182/conf/zoo.cfg
sed -i "s#^clientPort=.*#clientPort=2182#g" $ZOOKEEPER_DIR_2182/apache-zookeeper-3.6.0-2182/conf/zoo.cfg
echo "admin.serverPort=8082" >> $ZOOKEEPER_DIR_2182/apache-zookeeper-3.6.0-2182/conf/zoo.cfg