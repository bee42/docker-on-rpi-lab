#!/bin/sh

# resolve links - $0 may be a softlink
PRG="$0"

while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

PRGDIR=`dirname "$PRG"`

if [ ! -f ${CATALINA_HOME}/.tomcat_created ]; then
  ${PRGDIR}/create_tomcat_user.sh
fi

DIR=${DEPLOY_DIR:-/webapps}
echo "Checking *.war in $DIR"
if [ -d $DIR ]; then
  for i in $DIR/*.war; do
     file=$(basename $i)
     if [ ! "$file" == "*.war" ]; then
       echo "Linking $i --> ${CATALINA_HOME}/webapps/$file"
       ln -sf $i ${CATALINA_HOME}/webapps/$file
     fi
  done
  for i in $(ls -d $DIR/*/) ; do
    dir=$(basename $i)
    echo "Linking $dir --> ${CATALINA_HOME}/webapps/$dir"
    ln -sf $i ${CATALINA_HOME}/webapps/$dir
  done
fi

DIR=${LIBS_DIR:-/libs}
echo "Checking tomcat extended libs *.jar in $DIR"
if [ -d $DIR ]; then
  for i in $DIR/*.jar; do
     file=$(basename $i)
     echo "Linking $i --> ${CATALINA_HOME}/lib/$file"
     ln -s $i ${CATALINA_HOME}/lib/$file
  done
fi

# Autorestart possible?
#-XX:OnError="cmd args; cmd args"
#-XX:+HeapDumpOnOutOfMemoryError -XX:HeapDumpPath=/tmp/heapdump.hprof -XX:OnOutOfMemoryError="sh ~/cleanup.sh"

if [ "${JVM_ROUTE}z" == "z" ]; then
  if [ -x "/usr/local/bin/docker" ]; then
    ROUTE=$(docker inspect --format "{{ .Name }}" `hostname` | sed 's/^.//')
  else
    ROUTE=
  fi
  if [ "${ROUTE}z" == "z" ]; then
    TOMCAT_JVM_ROUTE=`hostname`
  else
    TOMCAT_JVM_ROUTE=$ROUTE
  fi
else
  TOMCAT_JVM_ROUTE=$JVM_ROUTE
fi

export LANG="en_US.UTF-8"
export JAVA_OPTS="$JAVA_OPTS -Duser.language=en -Duser.country=US"
export CATALINA_PID=${CATALINA_HOME}/temp/tomcat.pid
export CATALINA_OPTS="$CATALINA_OPTS \
 -server \
 -Xmx${JAVA_MAXMEMORY}m \
 -Djava.awt.headless=true \
 -DjvmRoute=${TOMCAT_JVM_ROUTE} \
 -Dtomcat.maxThreads=${TOMCAT_MAXTHREADS} \
 -Dtomcat.minSpareThreads=${TOMCAT_MINSPARETHREADS} \
 -Dtomcat.httpTimeout=${TOMCAT_HTTPTIMEOUT} \
 -Dtomcat.ajpTimeout=${TOMCAT_AJPTIMEOUT} \
 -Dtomcat.accessLogPattern='${TOMCAT_ACCESSLOG_PATTERN}' \
 -Djava.security.egd=file:/dev/./urandom \
 -Dsun.net.client.defaultReadTimeout=180000 \
 -Dsun.net.client.defaultConnectTimeout=180000 \
 -Djava.net.preferIPv4Stack=true \
 -Dsun.net.inetaddr.ttl=15 \
 -Djava.rmi.server.hostname=127.0.0.1 \
 -Djava.rmi.server.useLocalHostname=true \
 -Dcom.sun.management.jmxremote \
 -Dcom.sun.management.jmxremote.port=8001 \
 -Dcom.sun.management.jmxremote.rmi.port=8001 \
 -Dcom.sun.management.jmxremote.ssl=false"

if [ -r "$CATALINA_HOME/conf/jmxremote.access" ]; then
  export CATALINA_OPTS="$CATALINA_OPTS \
  -Dcom.sun.management.jmxremote.authenticate=true \
  -Dcom.sun.management.jmxremote.access.file=$CATALINA_HOME/conf/jmxremote.access \
  -Dcom.sun.management.jmxremote.password.file=$CATALINA_HOME/conf/jmxremote.password"
else
  export CATALINA_OPTS="$CATALINA_OPTS \
  -Dcom.sun.management.jmxremote.authenticate=false"
fi

cat ${CATALINA_HOME}/bin/infrabricks.txt
echo "     Power by Apache Tomcat"
echo "   https://tomcat.apache.org"
exec ${CATALINA_HOME}/bin/catalina.sh run
