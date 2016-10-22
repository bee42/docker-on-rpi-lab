# build open jdk java for arm


## create and test an image

```
$ docker build -t bee42/rpi-java:8-jre -f Dockerfile.8-jre .
$ docker run -ti --rm bee42/rpi-java:8-jre java -version
openjdk version "1.8.0_40-internal"
OpenJDK Runtime Environment (build 1.8.0_40-internal-b04)
OpenJDK Zero VM (build 25.40-b08, interpreted mode)
```

## push to queenshive

```
$ docker tag bee42/rpi-java:8-jre queenshive:5000/bee42/rpi-java:8-jre
$ docker push queenshive:5000/bee42/rpi-java:8-jre
```

## usage

### compile and run a java program inside a container

```
$ docker run --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp bee42/rpi-java:8-jdk javac Main.java
$ docker run -ti --rm -v "$PWD":/usr/src/myapp -w /usr/src/myapp bee42/rpi-java:8-jdk java -cp . Main
```

## Links

* https://hub.docker.com/_/openjdk/

regards
peter
