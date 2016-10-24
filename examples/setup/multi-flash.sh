#!/bin/bash
set -e 
set -x

CREW_NUMBER=05
CREW_ID=001

TMP_DIR=/tmp/hypriot
TMP_DEVICE_CONFIG=$TMP_DIR/device-init.yml

FLASH_PATH="$HOME/develop/docker/hypriot/flash"
FLASH=$FLASH_PATH/Darwin/flash

HOS_VERSION="1.1.0"

HOSTNAME="bee42-crew${CREW_NUMBER}-${CREW_ID}"

SSID=bee42-crew-${CREW_NUMBER}
SSID_PASSWORD=beehive42

TARGET_DISK=disks2

mkdir -p $TMP_DIR
touch $TMP_DEVICE_CONFIG

cat >$TMP_DEVICE_CONFIG << DEVICECONFIG
hostname: "$HOSTNAME"
wifi:
  interfaces:
    wlan0:
      ssid: "$SSID"
      password: "$SSID_PASSWORD"

DEVICECONFIG

echo "Current Configuration: "
cat $TMP_DEVICE_CONFIG

$FLASH -c $TMP_DEVICE_CONFIG https://github.com/hypriot/image-builder-rpi/releases/download/v${HOS_VERSION}/hypriotos-rpi-v${HOS_VERSION}.img.zip << USERINPUT
$TARGET_DISK
yes
USERINPUT

rm -rf $TMP_DIR
echo "Everything is finished now use your PI"
