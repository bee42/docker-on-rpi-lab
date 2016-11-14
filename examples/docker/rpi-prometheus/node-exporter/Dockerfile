FROM bee42/rpi-alpine

LABEL MAINTAINER="niclas.mietz@bee42.com"

ARG NODE_EXPORTER_VERSION
ENV NODE_EXPORTER_VERSION=${NODE_EXPORTER_VERSION:-0.12.0}

RUN apk update \
 && apk upgrade \
 && apk add openssl \
 && rm -rf /var/cache/apk/*

RUN mkdir -p /tmp/NODE_EXPORTER \
 && cd /tmp/NODE_EXPORTER \
 && wget https://github.com/prometheus/node_exporter/releases/download/${NODE_EXPORTER_VERSION}/node_exporter-${NODE_EXPORTER_VERSION}.linux-armv7.tar.gz \
 && tar xzf node_exporter-${NODE_EXPORTER_VERSION}.linux-armv7.tar.gz\
 && cd node_exporter-${NODE_EXPORTER_VERSION}.linux-armv7 \
 && cp node_exporter /bin/node_exporter \
 && cd / \
 && rm -rf /tmp/NODE_EXPORTER

ADD LICENSE /etc/LICENSE.NODE_EXPORTER
RUN COPYDATE=`date  +'%Y'` && echo "bee42 NODE_EXPORTER" >/etc/provisioned.NODE_EXPORTER && date >>/etc/provisioned.NODE_EXPORTER && echo >>/etc/provisioned.NODE_EXPORTER && echo " Copyright ${COPYDATE} by <niclas.mietz@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.NODE_EXPORTER

EXPOSE      9100
ENTRYPOINT  [ "/bin/node_exporter" ]


