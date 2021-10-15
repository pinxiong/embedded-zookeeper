# Purpose

Use docker to build independent two zookeeper instances, which use ports `2181` and `2182`

# How to work

+ install `docker` and `docker-compose` first

+ build image

+ start zookeeper instances

```shell
cd src
./zkCmd.sh start
```

+ stop zookeeper instances

```shell
cd src
./zkCmd.sh stop
```

+ reset zookeeper instances

```shell
cd src
./zkCmd.sh reset
```

+ get info of zookeeper instances

```shell
cd src
./zkCmd.sh status
```