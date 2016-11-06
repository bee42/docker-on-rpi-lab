FROM armhfbuild/golang:1.6-alpine

ENV REPO="docker/distribution"

RUN export OUTPUT_PATH=/output \
    && apk add --no-cache git make bash gcc linux-headers python musl-dev  \
    && go get -d github.com/$REPO \
    && cd $GOPATH/src/github.com/$REPO \
    && make binaries

RUN cp src/github.com/$REPO/bin/registry $OUTPUT_PATH/ 
