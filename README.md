# Purpose

Use docker to build independent two zookeeper instances, which use ports `2181` and `2182`

# How to work

+ install `docker` and `docker-compose` first


### Linux or Mac OS

The Linux zookeeper image [zookeeper](https://hub.docker.com/_/zookeeper) is **official image**, which can work well.

More importantly, I have verified the exposed ports (`2181` and `2182`) can be connected successfully.

+ start zookeeper instances

```shell
cd src/linux
./zkCmd.sh start
```

+ stop zookeeper instances

```shell
cd src/linux
./zkCmd.sh stop
```

+ reset zookeeper instances

```shell
cd src/linux
./zkCmd.sh reset
```

+ get info of zookeeper instances

```shell
cd src/linux
./zkCmd.sh status
```

### Windows

The Windows zookeeper image [zookeeper](https://hub.docker.com/r/tmather99/zookeeper-windowsservercore-ltsc2019) is **NOT** official image, which can build but I have **NOT** verified if the exposed ports (`2181` and `2182`) can be connected(maybe there is something wrong).

+ start zookeeper instances

```shell
cd src/windows
./zkCmd.sh start
```

+ stop zookeeper instances

```shell
cd src/windows
./zkCmd.sh stop
```

+ reset zookeeper instances

```shell
cd src/windows
./zkCmd.sh reset
```

+ get info of zookeeper instances

```shell
cd src/windows
./zkCmd.sh status
```