#!/bin/sh

docker build -t bee42/rpi-golang -t bee42/rpi-golang:1.7 .
docker build -t bee42/rpi-golang:onbuild -t bee42/rpi-golang:1.7-onbuild -f Dockerfile.onbuild .
