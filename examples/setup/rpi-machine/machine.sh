#!/bin/bash
set -e

: ${CREW_MEMBER:=01}
: ${CREW_ID:=001}
: ${CREW_MACHINE_NAME:="bee42-crew-$CREW_MEMBER-$CREW_ID"}
: ${CREW_MACHINE_IP:=192.168.${CREW_ID}.${CREW_MEMBER}

: ${PI_USERNAME:=pirate}
: ${PI_PASSWORD:=hypriot}

SSH_PORT=22
SSH_KEY_SIZE=4096
SSH_KEY_ALGO=rsa

: ${STORAGE_PATH:=$PWD/machine-config}

#if [ -f "$HOME/.ssh/id_rsa.pub" ]; then

#  ssh -p $SSH_PORT -q $PI_USERNAME@$CREW_MACHINE_IP exit
 # if [ $? -ne 0 ]; then
  #  echo "Copy SSH Key to: \n $PI_USERNAME@$CREW_MACHINE_IP:$SSH_PORT "
   #ssh-copy-id "$PI_USERNAME@$CREW_MACHINE_IP -p $SSH_PORT"
  #fi
#else

 # echo "Generate Key for User $(whomai)"
  #ssh-keygen -t $SSH_KEY_ALGO -b $SSH_KEY_SIZE

  #echo "Copy SSH Key to: \n $PI_USERNAME@$CREW_MACHINE_IP:$SSH_PORT "
  #ssh-copy-id "$PI_USERNAME@$IP_ADDRESS -p $SSH_PORT"
#fi

# deploy a Docker 1.12.x on ARMv6 or ARMv7 Raspbian/Jessie
docker-machine --debug --storage-path=$STORAGE_PATH create \
  --driver=generic \
  --generic-ip-address=$CREW_MACHINE_IP \
  --generic-ssh-port=$SSH_PORT \
  --generic-ssh-user=$PI_USERNAME \
  --engine-install-url=https://get.docker.com/ \
  --engine-insecure-registry beehive:5000 \
  --engine-storage-driver=overlay \
  $CREW_MACHINE_NAME

echo "Now lets connect to the machine with docker-machine ssh ${CREW_MACHINE_NAME}"
