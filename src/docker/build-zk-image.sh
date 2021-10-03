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


IS_WINDOWS_OS=true
# detect if the OS is windows
{
    if [[ `uname` == 'Linux' ]] || [[ `uname` == 'Darwin' ]]; then
		IS_WINDOWS_OS=false
	fi
} || {
	echo "This OS is windows."
	IS_WINDOWS_OS=true
}

DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
echo "Building zookeeper image..."
cd $DIR

if $IS_WINDOWS_OS
then
    docker build -f Dockerfile-windows -v /C/Users/systemDir:/usr/local/zookeeper -t dubbo/zookeeper:8 .
else
    docker build -f Dockerfile-unix -t dubbo/zookeeper:8 .
fi