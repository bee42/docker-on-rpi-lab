#!/bin/bash
set -e

docker build -t registry-build -f Dockerfile.build .

docker create --name registry-build-cp registry-build

docker cp registry-build-cp:/output .

docker build -t bee42/rpi-registry .

docker rm registry-build-cp
docker rmi registry-build
rm -rf output
