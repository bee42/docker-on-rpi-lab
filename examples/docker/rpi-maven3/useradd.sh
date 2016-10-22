#!/bin/bash

USERNAME=${USERNAME:-pirate}
GROUPNAME=${GROUPNAME:-pirate}
MUID=${MUID:-1000}
MGID=${MGID:-1000}

if [ ! "${USERNAME}" -eq "root"] ; then
  mkdir -p /home/${USERNAME}
  groupadd -r ${GROUPNAME} -g ${MGID}
  useradd -u ${MUID} -r -g ${USERNAME} -d /home/${USERNAME} \
    -s /bin/bash -c "bee42 ${USERNAME} developer" ${USERNAME}
  groupadd -r docker -g 112
  usermod -a -G docker pirate
  chown -R ${USERNAME}:${GROUPNAME} /home/${USERNAME}
fi
