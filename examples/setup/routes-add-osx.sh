#!/bin/bash
# Usage:
# Or be route
# sudo ./routes-add.sh 01 192.168.178.0/24

CREW_NUMBER=$1
NETWORK=$2

cat << BEFORE
routes before
-------------
route -n 
BEFORE



GATEWAY=$(nmap  -sn  "$NETWORK" -oG - | awk '/bee42-crew-'$CREW_NUMBER'/{print $2}')

route add -net 192.168.$CREW_NUMBER.0/24 $GATEWAY


cat << AFTER
routes after
-------------
route -n
AFTER
