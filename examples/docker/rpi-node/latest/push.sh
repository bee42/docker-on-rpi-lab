#!/bin/bash

VERSION=$(cat VERSION)

REPO=node
REMOTE_REGISTRY=127.0.0.1:5000

NEW_NAME=${REMOTE_REGISTRY}/bee42/rpi-${REPO}

docker tag bee42/rpi-${REPO}:$VERSION ${NEW_NAME}:$VERSION

docker push ${NEW_NAME}:$VERSION
docker push ${NEW_NAME}
