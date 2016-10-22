FROM bee42/rpi-java:8-jre

MAINTAINER Peter Rossbach <peter.rossbach@bee42.com> @PRossbach

ARG TOMCAT_MINOR_VERSION
ARG JOLOKIA_VERSION
ARG JAVA_MAXMEMORY
ARG TOMCAT_MAXTHREADS

ENV TOMCAT_MAJOR_VERSION=8 \
 TOMCAT_MINOR_VERSION=${TOMCAT_MINOR_VERSION:-8.0.38} \
 CATALINA_HOME=/opt/tomcat \
 JOLOKIA_VERSION=${JOLOKIA_VERSION:-1.3.5} \
 JAVA_MAXMEMORY=${JAVA_MAXMEMORY:-512} \
 TOMCAT_MAXTHREADS=${TOMCAT_MAXTHREADS:-250} \
 TOMCAT_MINSPARETHREADS=4 \
 TOMCAT_HTTPTIMEOUT=20000 \
 TOMCAT_AJPTIMEOUT=410000 \
 DEPLOY_DIR=/webapps \
 LIBS_DIR=/libs \
 PATH=$PATH:$CATALINA_HOME/bin \
 TOMCAT_ACCESSLOG_PATTERN="%{begin:yyyy-MM-dd'T'HH:mm:ss:SSSZ}t org.apache.catalina.valves.AccessLogValve access INFO: %h \"%r\" \"%{Referer}i\" \"%{User-Agent}i\" %s %b \"%I\" %D %S"

RUN DEBIAN_FRONTEND=noninteractive \
  apt-get update \
  && apt-get install -yq pwgen curl unzip \
  && apt-get clean autoclean \
  && apt-get autoremove -y \
  && rm -rf /var/lib/{apt,dpkg,cache,log}

RUN mkdir -p "$CATALINA_HOME"
WORKDIR $CATALINA_HOME

# see https://www.apache.org/dist/tomcat/tomcat-8/KEYS
RUN gpg --keyserver pool.sks-keyservers.net --recv-keys \
	05AB33110949707C93A279E3D3EFE6B686867BA6 \
	07E48665A34DCAFAE522E5E6266191C37C037D42 \
	47309207D818FFD8DCD3F83F1931D684307A10A5 \
	541FBE7D8F78B25E055DDEE13C370389288584E7 \
	61B832AC2F1C5A90F0F9B00A1C506407564C17A3 \
	79F7026C690BAA50B92CD8B66A3AD3F4F22C4FED \
	9BA44C2621385CB966EBA586F72C284D731FABEE \
	A27677289986DB50844682F8ACB77FC2E86E29AC \
	A9C5DF4D22E99998D9875A5110C01C5A2F6059E7 \
	DCFD35E0BF8CA7344752DE8B6FB21E8933C60243 \
	F3A04C595DB5B6A5F1ECA43E3B7BBB100D811BBE \
	F7DA48BB64BCB84ECBA7EE6935CD23C10D498E23 \
  && gpg --keyserver pgpkeys.mit.edu --recv-key EF101165


RUN  TOMCAT_TGZ_URL=https://archive.apache.org/dist/tomcat/tomcat-${TOMCAT_MAJOR_VERSION}/v${TOMCAT_MINOR_VERSION}/bin/apache-tomcat-${TOMCAT_MINOR_VERSION}.tar.gz &&  \
 echo $TOMCAT_TGZ_URL && curl -SL "$TOMCAT_TGZ_URL" -o tomcat.tar.gz \
	&& curl -SL "$TOMCAT_TGZ_URL.asc" -o tomcat.tar.gz.asc \
	&& gpg --verify tomcat.tar.gz.asc \
	&& tar -xvf tomcat.tar.gz --strip-components=1 \
	&& rm tomcat.tar.gz* \
  && rm -rf ${CATALINA_HOME}/webapps/* \
  ${CATALINA_HOME}/RELEASE-NOTES \
  ${CATALINA_HOME}/RUNNING.txt \
  ${CATALINA_HOME}/bin/*.bat \
  ${CATALINA_HOME}/bin/*.tar.gz \
  && mkdir -p ${CATALINA_HOME}/work ${CATALINA_HOME}/temp

RUN curl -SL "http://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-war/${JOLOKIA_VERSION}/jolokia-war-${JOLOKIA_VERSION}.war" -o ${CATALINA_HOME}/webapps/jolokia.war \
  && curl -SL "http://search.maven.org/remotecontent?filepath=org/jolokia/jolokia-war/${JOLOKIA_VERSION}/jolokia-war-${JOLOKIA_VERSION}.war.asc" -o ${CATALINA_HOME}/webapps/jolokia.war.asc \
  && gpg --verify ${CATALINA_HOME}/webapps/jolokia.war.asc \
  && mkdir -p ${CATALINA_HOME}/webapps/jolokia \
  && cd ${CATALINA_HOME}/webapps/jolokia \
  && unzip ../jolokia.war \
  && rm ${CATALINA_HOME}/webapps/jolokia.war*

ADD conf/server.xml ${CATALINA_HOME}/conf/server.xml
ADD conf/logging.properties ${CATALINA_HOME}/conf/logging.properties
ADD bin/* ${CATALINA_HOME}/bin/
RUN chmod +x ${CATALINA_HOME}/bin/*.sh
ADD lib/tomcat-extensions.jar ${CATALINA_HOME}/lib/tomcat-extensions.jar
ADD lib/jolokia-access.xml ${CATALINA_HOME}/lib/jolokia-access.xml

EXPOSE 8080
EXPOSE 8009

ADD LICENSE /etc/LICENSE.tomcat8
RUN COPYDATE=`date  +'%Y'` \
 && echo "infrabricks tomcat8" >/etc/provisioned.tomcat8 \
 && date >>/etc/provisioned.tomcat8 \
 && echo >>/etc/provisioned.tomcat8 \
 && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.tomcat8

CMD ["/opt/tomcat/bin/tomcat.sh"]
