# Apache Maven as docker container

see article from JavaMagazin 04/2015 Peter Rossbach

* package maven into docker container
* show shell alias mvn (.bash_aliases)
* see trick to reuse $HOME/.m2 artefact cache


## build for user roor only

```
./build.sh
```

* only works for windows and mac user if you share your files via virtualbox share!
* if you work as root with linux!

## check installation

```
$ mkdir -p $HOME/.m2
$ docker run --rm bee42/maven:rpi-3
Apache Maven 3.3.3 (7994120775791599e205a5524ec3e0dfe41d4a06; 2015-04-22T11:57:37+00:00)
Maven home: /usr/share/maven
Java version: 1.8.0_66-internal, vendor: Oracle Corporation
Java home: /usr/lib/jvm/java-8-openjdk-amd64/jre
Default locale: en, platform encoding: UTF-8
OS name: "linux", version: "4.0.9-boot2docker", arch: "amd64", family: "unix"
```

### use this docker maven

```
# create maven cache set correct pirate user rights!
$ mkdir ~/.m2
cd ../../examples/java/spring-boot/demo
$ docker run --rm -ti -v $(pwd):/app -w /app \
 -v ~/.m2:/home/pirate/.m2 \
 bee42/maven:rpi-3 package
$ docker run --rm -ti -p 8080 -v $(pwd):/app -w /app \
 -v ~/.m2:/home/pirate/.m2 \
 bee42/maven:rpi-3 \
 -Djava.security.egd=file:/dev/urandom \
 spring-boot:run
$ docker run --rm -ti -v $(pwd):/app -w /app \
 -v ~/.m2:/home/pirate/.m2 \
 -v /var/run/docker.sock:/run/docker.sock \
 bee42/maven:rpi-3 docker:build
$ docker run -d -P bee42/demo
$ alias mvn="docker run --rm -ti -v \$(pwd):/app -w /app \
 -v ~/.m2:/home/pirate/.m2 \
 -v /var/run/docker.sock:/run/docker.sock \
 bee42/maven:rpi-3"
```

## usage only as pirate!

```
docker build -f Dockerfile.1.9 \
 --build-arg USERNAME=pirate \
 --build-arg GROUPNAME=pirate \
 --build-arg MUID=1000 \
 --build-arg GUID=1000 \
 -t bee42/maven:rpi-3-pirate .
```

current user

```
GID=$(cat /etc/passwd |grep $USER | awk 'BEGIN { FS = ":" } ; { print $4 }')
GROUPNAME=$(grep ${GID} /etc/group | awk 'BEGIN {FS = ":"} ; { print $1}')

docker build -f Dockerfile.1.9 \
 --build-arg USERNAME=$USER \
 --build-arg GROUPNAME=$GROUPNAME \
 --build-arg MUID=$UID \
 --build-arg GUID=$GID \
 -t bee42/maven:rpi-3-$USER .
```

```
$ alias mvn="docker run --rm \
  --user \${USER} \
  -v \$(pwd):/app -w /app -v ${HOME}/.m2:/home/\${USER}/.m2 \
  bee42/maven:3-\${USER}"
$ mvn archetype:generate \
 -DgroupId="io.infrabricks.example" \
 -DartifactId="my-app" \
 -DarchetypeArtifactId="maven-archetype-quickstart" \
 -DinteractiveMode="false"
...
$ cd my-app
$ mvn clean package
...
$ alias java="docker run --rm \
 --user \${USER}
 -v \$(pwd):/app -w /app \
 --entrypoint=java bee42/maven:3-\${USER}"
$ java -cp target/my-app-1.0-SNAPSHOT.jar io.infrabricks.example.App
Hello World!
```

### Add mobydock user support

```
$ cat >Dockerfile.mobydock <<EOF
FROM maven:3
RUN mkdir -p /home/mobydock \
 && groupadd -r mobydock -g 4284 \
 && useradd -u 4221 -r -g mobydock -d /home/mobydock -s /bin/bash -c "infrabricks mobydock developer" mobydock \
 && groupadd -r mobydock -g 999 \
 && usermod -a -G docker mobydock \
 && chown -R mobydock:mobydock /home/mobydock
EOF
$ docker build -f Dockerfile.mobydock -t maven:rpi-3-mobydock .

$ alias mvn="docker run --rm \
  --user=\${USER} -v \$(pwd):/app -w /app -v \${HOME}/.m2:/home/\${USER}/.m2 \
  maven:rpi-3-mobydock mvn"
```

## Links

* https://maven.apache.org/
* http://www.torsten-horn.de/techdocs/maven.htm
* https://www.jfrog.com/open-source/
  * Artifactory
