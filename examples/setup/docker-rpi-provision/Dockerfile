FROM alpine:3.4

MAINTAINER Niclas Mietz <niclas.mietz@bee42.com> @solidnerd

ARG MACHINE_VERSION
ENV MACHINE_VERSION=${MACHINE_VERSION:-0.8.2}

RUN apk add -U --no-cache curl ca-certificates openssh-client bash \
    && curl -L https://github.com/docker/machine/releases/download/v${MACHINE_VERSION}/docker-machine-`uname -s`-`uname -m` >/usr/local/bin/docker-machine \
    && chmod +x /usr/local/bin/docker-machine

COPY rpi-provision.sh /usr/local/bin/rpi-provision.sh

RUN chmod +x /usr/local/bin/rpi-provision.sh

VOLUME [$STORAGE_PATH]

ENTRYPOINT ["/usr/local/bin/rpi-provision.sh"]
