#!/bin/bash
NAME=bee42

docker build -t $NAME/node:$(cat VERSION) .
docker build -t $NAME/node:latest .