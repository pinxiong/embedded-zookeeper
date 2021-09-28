# Purpose

Use docker to build independent two zookeeper instances, which use ports `2181` and `2182`

# How to work

+ install `docker` and `docker-compose` first

+ build image

```shell
cd src/docker
./build-zk-image.sh
```

+ start container

```she
docker run --privileged -it --name="dubbo-zookeeper" dubbo/zookeeper:8  -p 2181:2181 2182:2182 /bin/bash
```

+ start zookeeper

```shell
docker exec -it dubbo-zookeeper /bin/sh /usr/local/zookeeper/zkCmd.sh start
```