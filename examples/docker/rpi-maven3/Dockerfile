FROM bee42/rpi-java:8-jdk
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com> @PRossbach
ENV MAVEN_VERSION=3.3.9 \
    MAVEN_HOME=/usr/share/maven

RUN apt-get update \
 && apt-get install -y curl \
 && rm -rf /var/lib/apt/lists/*

RUN export URL=https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries && \
 curl -fsSL --insecure $URL/apache-maven-$MAVEN_VERSION-bin.tar.gz \
 | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION $MAVEN_HOME \
  && ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn

RUN mkdir -p /home/pirate \
 && groupadd -r pirate -g 1000 \
 && useradd -u 1000 -r -g pirate -d /home/pirate -s /bin/bash -c "bee42 pirate developer" pirate \
 && groupadd -r docker -g 112 \
 && usermod -a -G docker pirate \
 && chown -R pirate:pirate /home/pirate

ADD LICENSE /etc/LICENSE.maven
RUN COPYDATE=`date  +'%Y'` && echo "bee42 maven" >/etc/provisioned.maven && date >>/etc/provisioned.maven && echo >>/etc/provisioned.maven && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.maven

USER pirate
ENTRYPOINT ["mvn"]
CMD ["--version"]
