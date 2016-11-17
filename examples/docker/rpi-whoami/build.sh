#!/bin/bash
set -e

REPO=whoami

docker build -t ${REPO}-build -f Dockerfile.build .

docker create --name ${REPO}-build-cp ${REPO}-build

docker cp ${REPO}-build-cp:/output .

docker build -t bee42/rpi-${REPO} .

docker rm ${REPO}-build-cp
docker rmi ${REPO}-build
rm -rf output
