#!/bin/bash
DECK=docker-on-arm
docker build -t="rossbachp/$DECK" .
DATE=`date +'%Y%m%d%H%M'`
ID=$(docker inspect -f "{{.Id}}" rossbachp/$DECK)
docker tag $ID rossbachp/$DECK:$DATE
#docker push rossbachp/$DECK
