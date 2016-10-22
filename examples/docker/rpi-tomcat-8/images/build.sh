#!/bin/bash
IMAGE=tomcat
ACCOUNT=infrabricks
TAG_SHORT=8
TAG_LONG=8.0.33
docker build -t="${ACCOUNT}/$IMAGE" .
DATE=`date +'%Y%m%d%H%M'`
IID=$(docker inspect -f "{{.Id}}" ${ACCOUNT}/$IMAGE)
docker tag -f $IID ${ACCOUNT}/$IMAGE:$DATE
docker tag -f $IID ${ACCOUNT}/$IMAGE:$TAG_SHORT
docker tag -f $IID ${ACCOUNT}/$IMAGE:$TAG_LONG
