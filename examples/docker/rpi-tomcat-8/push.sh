#!/bin/bash
IMAGE=tomcat
ACCOUNT=bee42
TAG_SHORT=rpi-8
TAG_LONG=rpi-8.0.38
REGISTRY=queenshive:5000

docker push ${REGISTRY}/${ACCOUNT}/$IMAGE:latest
docker push ${REGISTRY}/${ACCOUNT}/$IMAGE:$TAG_SHORT
docker push ${REGISTRY}/${ACCOUNT}/$IMAGE:$TAG_LONG
