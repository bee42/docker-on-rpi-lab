#!/bin/bash
#set -e

set -x



MACHINE_NAME="bee42-crew-$MACHINE_ID-$CREW_NUMBER"

IP_CREW_NUMBER=$(echo $CREW_NUMBER | sed 's/^0*//')
IP_MACHINE_ID=$(echo $MACHINE_ID | sed 's/^0*//')
IP_ADDRESS="192.168.$IP_MACHINE_ID.$IP_CREW_NUMBER"
SSH_ADDRESS="$PI_USERNAME@$IP_ADDRESS"

STORAGE_PATH=$CONFIG_PATH/.docker-machine
SSH_KEY_PATH=$CONFIG_PATH/.ssh

SSH_KEY=$SSH_KEY_PATH/id_$SSH_KEY_ALGO

function copy_ssh_key(){
  echo "Copy SSH Key to: \n $PI_USERNAME@$IP_ADDRESS:$IP_PORT "
  ssh-copy-id -p $SSH_PORT  -i $SSH_KEY $PI_USERNAME@$IP_ADDRESS
}

function generate_ssh_key(){
   ssh-keygen -t $SSH_KEY_ALGO -b $SSH_KEY_SIZE -f "$SSH_KEY"
}

if [ -f "$SSH_KEY" ]; then
 ssh -p $SSH_PORT -o BatchMode=yes "$SSH_ADDRESS"
 result=$?
 echo $result
 if [ $result -ne 0 ]; then
  copy_ssh_key
 fi
else
  generate_ssh_key
  copy_ssh_key
fi

echo "Fix Hypriot OS for Docker Machine"
ssh -p $SSH_PORT "$SSH_ADDRESS" -i $SSH_KEY "curl -sSL https://github.com/DieterReuter/arm-docker-fixes/raw/master/001-fix-docker-machine-1.8.0-create-for-arm/apply-fix-001.sh | bash"

#deploy a Docker 1.12.1 on ARMv6 or ARMv7 Raspbian/Jessie
docker-machine --debug --storage-path=$STORAGE_PATH create \
  --driver=generic \
  --generic-ip-address=$IP_ADDRESS \
  --generic-ssh-port=$SSH_PORT \
  --generic-ssh-user=$PI_USERNAME \
  --generic-ssh-key=$SSH_KEY \
  --engine-install-url=https://get.docker.com/ \
  --engine-storage-driver=overlay \
  --engine-insecure-registry $ENGINE_INSECURE_REGISTRY \
  $MACHINE_NAME

echo "Now lets connect to the machine"
