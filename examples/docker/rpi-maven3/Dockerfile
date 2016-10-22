FROM bee42/rpi-java:8-jdk
MAINTAINER Peter Rossbach <peter.rossbach@bee42.com> @PRossbach
ENV MAVEN_VERSION=3.3.9 \
    MAVEN_HOME=/usr/share/maven

RUN export URL=https://archive.apache.org/dist/maven/maven-3/$MAVEN_VERSION/binaries && \
 curl -fsSL --insecure $URL/apache-maven-$MAVEN_VERSION-bin.tar.gz \
 | tar xzf - -C /usr/share \
  && mv /usr/share/apache-maven-$MAVEN_VERSION $MAVEN_HOME \
  && ln -s $MAVEN_HOME/bin/mvn /usr/bin/mvn

RUN mkdir -p /home/priate \
 && groupadd -r priate -g 1000 \
 && useradd -u 1000 -r -g priate -d /home/priate -s /bin/bash -c "bee42 pirate developer" mobydock \
 && groupadd -r docker -g 112 \
 && usermod -a -G docker pirate \
 && chown -R pirate:pirate /home/pirate

ADD LICENSE /etc/LICENSE.java
RUN COPYDATE=`date  +'%Y'` && echo "bee42 java" >/etc/provisioned.java && date >>/etc/provisioned.java && echo >>/etc/provisioned.java && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.java

USER mobydock
ENTRYPOINT ["mvn"]
CMD ["--version"]
