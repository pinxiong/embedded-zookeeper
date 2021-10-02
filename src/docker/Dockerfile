#   Licensed to the Apache Software Foundation (ASF) under one or more
#   contributor license agreements.  See the NOTICE file distributed with
#   this work for additional information regarding copyright ownership.
#   The ASF licenses this file to You under the Apache License, Version 2.0
#   (the "License"); you may not use this file except in compliance with
#   the License.  You may obtain a copy of the License at
#
#       http://www.apache.org/licenses/LICENSE-2.0
#
#   Unless required by applicable law or agreed to in writing, software
#   distributed under the License is distributed on an "AS IS" BASIS,
#   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
#   See the License for the specific language governing permissions and
#   limitations under the License.

FROM openjdk:8

#ARG DEBIAN_MIRROR
#RUN if [ -n "$DEBIAN_MIRROR" ]; then \
#  sed -i "s@http://deb.debian.org@${DEBIAN_MIRROR}@g" /etc/apt/sources.list && \
#  sed -i "s@http://security.debian.org@${DEBIAN_MIRROR}@g" /etc/apt/sources.list && \
#  cat /etc/apt/sources.list ; fi

RUN apt-get update && \
  apt-get install -y telnet && \
  apt-get install -y wget && \
  rm -rf /var/lib/apt/lists/* && \
  mkdir -p /usr/local/zookeeper && \
  wget -O /usr/local/zookeeper/apache-zookeeper.tar.gz -c -N --show-progress  https://archive.apache.org/dist/zookeeper/zookeeper-3.6.0/apache-zookeeper-3.6.0-bin.tar.gz

VOLUME /usr/local/zookeeper

WORKDIR /usr/local/zookeeper/

COPY ./init.sh ./zkCmd.sh /usr/local/zookeeper/

EXPOSE 2181 2182

#ENTRYPOINT exec build zookeeper instances
ENTRYPOINT ["bash", "-x", "./init.sh"]