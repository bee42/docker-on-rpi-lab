#!/bin/bash
IMAGE=tomcat
ACCOUNT=infrabricks
TAG_SHORT=8
TAG_LONG=8.0.28

docker push ${ACCOUNT}/$IMAGE:latest
docker push ${ACCOUNT}/$IMAGE:$TAG_SHORT
docker push ${ACCOUNT}/$IMAGE:$TAG_LONG
docker push ${ACCOUNT}/${IMAGE}:${TAG_LONG}-dev
docker push ${ACCOUNT}/${IMAGE}:${TAG_LONG}-tcnative
docker push ${ACCOUNT}/${IMAGE}:${TAG_LONG}-onbuild
docker push ${ACCOUNT}/${IMAGE}:${TAG_LONG}-volume
