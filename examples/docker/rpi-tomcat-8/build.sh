#!/bin/bash
IMAGE=tomcat
ACCOUNT=bee42
TAG_SHORT=rpi-8
TAG_LONG=rpi-8.0.38
REGISTRY=queenshive:5000
docker build -t="${ACCOUNT}/$IMAGE" .
DATE=`date +'%Y%m%d%H%M'`
IID=$(docker inspect -f "{{.Id}}" ${ACCOUNT}/$IMAGE)
docker tag $IID ${ACCOUNT}/$IMAGE:$DATE
docker tag $IID ${ACCOUNT}/$IMAGE:$TAG_SHORT
docker tag $IID ${ACCOUNT}/$IMAGE:$TAG_LONG
docker tag $IID ${REGISTRY}/${ACCOUNT}/$IMAGE:$DATE
docker tag $IID ${REGISTRY}/${ACCOUNT}/$IMAGE:$TAG_SHORT
docker tag $IID ${REGISTRY}/${ACCOUNT}/$IMAGE:$TAG_LONG
