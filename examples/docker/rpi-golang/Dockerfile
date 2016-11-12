FROM resin/rpi-raspbian:jessie

MAINTAINER Peter Rossbach <peter.rossbach@bee42.com> @PRossbach

ARG GOLANG_VERSION
ENV GOLANG_VERSION=${GOLANG_VERSION:-1.7.3}

RUN apt-get update \
 && apt-get install -y openssl--no-install-recommends openssl\
 && rm -rf /var/lib/apt/lists/*

RUN mkdir -p /usr/local/go \
 && cd /tmp \
 && wget https://storage.googleapis.com/golang/go${GOLANG_VERSION}.linux-armv6l.tar.gz \
 && tar -C /usr/local -xzf go${GOLANG_VERSION}.linux-armv6l.tar.gz \
 && rm /tmp/go${GOLANG_VERSION}.linux-armv6l.tar.gz

ADD LICENSE /etc/LICENSE.golang

RUN COPYDATE=`date  +'%Y'` && echo "bee42 golang" >/etc/provisioned.golang && date >>/etc/provisioned.golang && echo >>/etc/provisioned.golang && echo " Copyright ${COPYDATE} by <peter.rossbach@bee42.com> bee42 solutions gmbh" >>/etc/provisioned.golang

VOLUME     [ "/go" ]

ENV GOROOT=/usr/local/go
ENV GOPATH /go
ENV PATH $GOPATH/bin:/usr/local/go/bin:$PATH

WORKDIR $GOPATH

COPY go-wrapper /usr/local/bin/
