FROM bee42/rpi-alpine

MAINTAINER Peter Rossbach <peter.rossbach@bee42.com> @PRossbach

ARG TRAEFIK_VERSION
ENV TRAEFIK_VERSION=${TRAEFIK_VERSION:-1.1.0-rc4}

RUN apk update \
 && apk add openssl ca-certificates \
 && rm -rf /var/cache/apk/*

RUN mkdir -p /tmp/traefik \
 && cd /tmp/traefik \
 && wget https://github.com/containous/traefik/releases/download/v${TRAEFIK_VERSION}/traefik_linux-arm \
 && mv traefik_linux-arm /usr/local/bin/traefik \
 && chmod +x /usr/local/bin/traefik
 && cd / \
 && rm -rf /tmp/traefik

ADD traefik.toml /etc/traefik/traefik.toml
ADD LICENSE /etc/LICENSE.traefik
RUN COPYDATE=`date  +'%Y'` && echo "bee42 traefik" >/etc/provisioned.traefik && date >>/etc/provisioned.traefik && echo >>/etc/provisioned.traefik && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.traefik

EXPOSE     80 8080
VOLUME     [ "/traefik" ]
WORKDIR    /traefik
ENTRYPOINT [ "/usr/local/bin/traefik" ]
CMD        [ "--configFile=/etc/traefik/traefik.toml" ]
