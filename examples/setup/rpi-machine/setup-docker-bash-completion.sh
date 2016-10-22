#!/bin/bash

COMPOSE_VERSION=1.8.1
MACHINE_VERSION=v0.8.2

curl -Ls https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/con
trib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
chmod +xr /etc/bash_completion.d/docker-compose
curl -Ls https://raw.githubusercontent.com/docker/docker/master/contrib/completi
on/bash/docker > /etc/bash_completion.d/docker
chmod +xr /etc/bash_completion.d/docker
curl -Ls https://raw.githubusercontent.com/docker/machine/${MACHINE_VERSION}/con
trib/completion/bash/docker-machine.bash > /etc/bash_completion.d/docker-machine
curl -Ls https://raw.githubusercontent.com/docker/machine/${MACHINE_VERSION}/con
trib/completion/bash/docker-machine-wrapper.bash > /etc/bash_completion.d/docker
-machine-wrapper
curl -Ls https://raw.githubusercontent.com/docker/machine/${MACHINE_VERSION}/con
trib/completion/bash/docker-machine-prompt.bash > /etc/bash_completion.d/docker-
machine-prompt
chmod +xr /etc/bash_completion.d/docker-machine*

cat >>/etc/profile <<EOF
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi
EOF

echo ":set term=ansi" >>/root/.vimrc

