#!/bin/bash
NAME=bee42
docker build -t $NAME/rpi-node:$(cat VERSION) .
