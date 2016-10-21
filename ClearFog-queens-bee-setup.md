# Install Queenshive at Clear Fog

## Flash the OS-Images

* use mini SD Card to SD Card Adapter
* download the os Images from http://www.armbian.com/clearfog/

```
$ flash Armbian_5.20_Armada_Debian_jessie_4.7.3.img
```

* https://github.com/hypriot/flash

## download and install USB to RS232 driver at your Mac

* http://www.ftdichip.com/Drivers/VCP/MacOSX/FTDIUSBSerialDriver_v2_3.dmg

## USB Connect to RS232 Clearfog Port

![](images/clearfog-usb-rs232.jpg)

* add mini usb cable
* Add ethernet lan cable to connect to internet router
* add ssd card to mPIC slot
* switch clear fog on

### install docker at your clear fog

```
$ ls /dev/tty.usbserial--*
tty.usbserial-DJ00HMV3
$ screen /dev/tty.usbserial-DJ00HMV3 115200
# enter root/1234, setup better password and create new regina user
$ fdisk -l
# create primary partition
$ fdisk /dev/sda
m
p
w
# format device /dev/sda1
$ mkfs.ext4 /dev/sda1
# add /dev/sda1 mount point
$ mkdir -p /ssd
# add mount point
$ vi /etc/fstab
/dev/sda1 /ssd ext4 defaults,noatime,nodiratime,commit=600,errors=remount-ro 0 1
$ mkdir -p /ssd/docker
$ ln -s /ssd/docker /var/lib/docker
$ curl -L http://test.docker.com | sh
$ sudo usermod -aG docker regina
$ echo > /etc/docker/daemon.json <<EOF
{
 "storage-driver": "overlay2"
}
EOF
$ systemctl restart docker.services
$ docker info
```

# Setup more parameter
* https://docs.docker.com/engine/reference/commandline/dockerd/
* https://gist.github.com/solidnerd/71825ac4f1d6d475f60aaf8e62009926

## Setup registry

![](images/docker-distribution-logo.png)

make at clearfog don`t work.

* old go
* wrong dependencies to distribution head imports

```
$ apt-get update
$ apt-get upgrade

# zu alt
$ apt-get install -y golang
$ git clone https://github.com/silverwind/armhf-registry
$ cd armhf-registry
$ mkdir -p /ssd/go
$ export GOPATH=/ssd/go
$ make
# break
```

```
$ docker pull silverwind/armhf-registry
$ docker run -p 5000:5000 -d silverwind/armhf-registry
```

* https://community.online.net/t/how-to-setup-your-private-docker-registry-on-armv7/1653

```
registry:
  restart: always
  image: silverwind/armhf-registry
  ports:
    - 5000:5000
  environment:                                             
     REGISTRY_HTTP_TLS_CERTIFICATE: /certs/domain.crt
     REGISTRY_HTTP_TLS_KEY: /certs/domain.key
     REGISTRY_AUTH: htpasswd
     REGISTRY_AUTH_HTPASSWD_PATH: /auth/htpasswd
     REGISTRY_AUTH_HTPASSWD_REALM: Registry Realm
volumes:
  - /root/registry/auth:/auth
  - /root/registry/certs:/certs
```

* Create Certs
* Create Auth
* get docker Compose

```
registry:
  restart: always
  image: silverwind/armhf-registry
  ports:
    - 5000:5000
  volumes:
    - /ssd/registry:/data
```

docker pull hypriot/hypriot/rpi-alpine-scratch
docker tag hypriot/rpi-alpine-scratch 127.0.0.1:5000/hypriot/rpi-alpine-scratch

## Hypriot Schatzkiste

* https://packagecloud.io/Hypriot/Schatzkiste/install

```
$ curl -s https://packagecloud.io/install/repositories/Hypriot/Schatzkiste/script.deb.sh | sudo bash
$ apt-get install docker-compose docker-machine
```

### bash completion?

```
#!/bin/bash

COMPOSE_VERSION=1.8.1
MACHINE_VERSION=v0.8.2

curl -Ls https://raw.githubusercontent.com/docker/compose/${COMPOSE_VERSION}/contrib/completion/bash/docker-compose > /etc/bash_completion.d/docker-compose
chmod +xr /etc/bash_completion.d/docker-compose
curl -Ls https://raw.githubusercontent.com/docker/docker/master/contrib/completion/bash/docker > /etc/bash_completion.d/docker
chmod +xr /etc/bash_completion.d/docker
curl -Ls https://raw.githubusercontent.com/docker/machine/${MACHINE_VERSION}/contrib/completion/bash/docker-machine.bash > /etc/bash_completion.d/docker-machine
curl -Ls https://raw.githubusercontent.com/docker/machine/${MACHINE_VERSION}/contrib/completion/bash/docker-machine-wrapper.bash > /etc/bash_completion.d/docker-machine-wrapper
curl -Ls https://raw.githubusercontent.com/docker/machine/${MACHINE_VERSION}/contrib/completion/bash/docker-machine-prompt.bash > /etc/bash_completion.d/docker-machine-prompt
chmod +xr /etc/bash_completion.d/docker-machine*

cat >>/etc/profile <<EOF
if [ -f /etc/bash_completion ]; then
 . /etc/bash_completion
fi
EOF

echo ":set term=ansi" >>/root/.vimrc
```

##  Routing

* http://www.cyberciti.biz/faq/linux-route-add/


## Provision PI's with ssl and swarm init

* Create Certs and open remote docker engines.
* example swarm init with docker machine config?

## access from your Mac

```
$ brew install tmate.io
```

* https://tmate.io/
