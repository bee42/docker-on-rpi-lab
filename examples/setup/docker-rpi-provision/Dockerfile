FROM alpine:3.4

LABEL MAINTAINER niclas@mietz.io

RUN apk add -U --no-cache curl ca-certificates openssh-client bash \
    && curl -L https://github.com/docker/machine/releases/download/v0.8.2/docker-machine-`uname -s`-`uname -m` >/usr/local/bin/docker-machine \
    && chmod +x /usr/local/bin/docker-machine

COPY rpi-provision.sh /usr/local/bin/rpi-provision.sh

RUN chmod +x /usr/local/bin/rpi-provision.sh

VOLUME [$STORAGE_PATH]

ENTRYPOINT ["/usr/local/bin/rpi-provision.sh"]

