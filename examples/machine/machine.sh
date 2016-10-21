#!/bin/bash
set -e

CREW_NUMBER=01
MACHINE_ID=002
MACHINE_NAME="bee42-crew-$CREW_NUMBER-$MACHINE_ID"

IP_ADDRESS=192.168.1.101
SSH_PORT=22

PI_USERNAME=pirate
PI_PASSWORD=hypriot

SSH_KEY_SIZE=4096
SSH_KEY_ALGO=rsa

STORAGE_PATH=$PWD/machine-config

#if [ -f "$HOME/.ssh/id_rsa.pub" ]; then

#  ssh -p $SSH_PORT -q $PI_USERNAME@$IP_ADDRESS exit
 # if [ $? -ne 0 ]; then
  #  echo "Copy SSH Key to: \n $PI_USERNAME@$IP_ADDRESS:$IP_PORT "
   #ssh-copy-id "$PI_USERNAME@$IP_ADDRESS -p $SSH_PORT"
  #fi
#else

 # echo "Generate Key for User $(whomai)"
  #ssh-keygen -t $SSH_KEY_ALGO -b $SSH_KEY_SIZE

  #echo "Copy SSH Key to: \n $PI_USERNAME@$IP_ADDRESS:$IP_PORT "
  #ssh-copy-id "$PI_USERNAME@$IP_ADDRESS -p $SSH_PORT"
#fi

# deploy a Docker 1.12.1 on ARMv6 or ARMv7 Raspbian/Jessie
docker-machine --debug --storage-path=$STORAGE_PATH create \
  --driver=generic \
  --generic-ip-address=$IP_ADDRESS \
  --generic-ssh-port=$SSH_PORT \
  --generic-ssh-user=$PI_USERNAME \
  --engine-install-url=https://get.docker.com/ \
  --engine-storage-driver=overlay \
  $MACHINE_NAME

echo "Now lets connect to the machine"
