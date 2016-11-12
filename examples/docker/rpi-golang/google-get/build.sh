#!/bin/sh

cp /etc/ssl/certs/ca-certificates.crt .
docker run --rm \
 -v `pwd`:/go \
 -e GOOS=linux -e CGO_ENABLED=0 \
 bee42/rpi-golang \
 go build -a -installsuffix cgo -ldflags="-s -w" -o main .
docker build -t google-get-scratch -f Dockerfile.scratch .
