#!/bin/bash
NAME=bee42
docker build -t $NAME/node:$(cat VERSION) .