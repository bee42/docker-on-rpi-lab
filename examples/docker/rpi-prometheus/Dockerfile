FROM bee42/rpi-alpine

MAINTAINER Peter Rossbach <peter.rossbach@bee42.com> @PRossbach

ARG PROMETHEUS_VERSION
ENV PROMETHEUS_VERSION=${PROMETHEUS_VERSION:-1.2.1}

RUN apk update \
 && apk upgrade\
 && apk add openssl \
 && rm -rf /var/cache/apk/*

RUN mkdir -p /tmp/prometheus \
 && cd /tmp/prometheus \
 && wget https://github.com/prometheus/prometheus/releases/download/v${PROMETHEUS_VERSION}/prometheus-${PROMETHEUS_VERSION}.linux-armv5.tar.gz \
 && tar xzf prometheus-${PROMETHEUS_VERSION}.linux-armv5.tar.gz \
 && cd prometheus-${PROMETHEUS_VERSION}.linux-armv5 \
 && cp prometheus /bin/prometheus \
 && cp promtool /bin/promtool \
 && mkdir -p /etc/prometheus \
 && cp prometheus.yml /etc/prometheus/prometheus.yml \
 && mkdir -p /usr/share/prometheus/console_libraries/ \
 && cp -r console_libraries/ /usr/share/prometheus/console_libraries/ \
 && mkdir -p /usr/share/prometheus/consoles/ \
 && cp -r consoles/ /usr/share/prometheus/consoles/ \
 && cd / \
 && rm -rf /tmp/prometheus

ADD LICENSE /etc/LICENSE.prometheus
RUN COPYDATE=`date  +'%Y'` && echo "bee42 prometheus" >/etc/provisioned.prometheus && date >>/etc/provisioned.prometheus && echo >>/etc/provisioned.prometheus && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.prometheus

EXPOSE     9090
VOLUME     [ "/prometheus" ]
WORKDIR    /prometheus
ENTRYPOINT [ "/bin/prometheus" ]
CMD        [ "-config.file=/etc/prometheus/prometheus.yml", \
             "-storage.local.path=/prometheus", \
             "-web.console.libraries=/usr/share/prometheus/console_libraries", \
             "-web.console.templates=/usr/share/prometheus/consoles" ]
