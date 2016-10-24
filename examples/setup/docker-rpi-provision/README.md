# rpi lab provisioning

## Quick setup

1. Clone the Repository and switch to it.

```
$ git clone https://github.com/bee42/docker-on-rpi-lab
$ cd docker-on-rpi-lab/examples/setup/docker-rpi-provision
```

2. `docker-compose build`

3. Edit `rpi-provision.env` like you want .

3.1 Connect your MAC Host to the pi wlan or setup a route at your mac

Find your Mini Router wlan ip with nmap

```
# install nmap
$ brew install nmap
$ nmap -sn 192.168.178.0/24
```

add your crew network to your mac

```
# sysctl -w net.ipv4.ip_forward=1
$ sudo route add -net 192.168.3.0 netmask 255.255.255.0 gw 192.168.178.68
# later remove the route
$ sudo route del -net 192.168.3.0 netmask 255.255.255.0
```

4. `docker-compose run --rm rpi-provision`

5. `sudo ln -s  $(pwd)/config /machine`
  Conncect from your mac with docker machine to your pi's

6. `docker-machine --storage-path=$(pwd)/config/.docker-machine  ls` or `docker-machine --storage-path=/machine/.docker-machine ls`

7. Connect via SSH

```bash
$ docker-machine --storage-path=$(pwd)/config/.docker-machine  ssh bee42-crew-xx-xx
```

8. Connect to Engine

```bash
$ docker-machine --storage-path=$(pwd)/config/.docker-machine  env bee42-crew-xx-xxx
```

## Special case regenerate certs

```bash
docker-machine --storage-path=$(pwd)/config/.docker-machine  regenerate-certs bee42-crew-xx-xxx
```
## WIP AREA

### Configuration Parameters
| Parameter                  | Defaults          |
|:---------------------------|:------------------|
| `CREW_NUMBER`              | `03`              |
| `MACHINE_ID`               | `001`             |
| `CONFIG_PATH`              | `/machine`        |
| `SSH_PORT`                 | `22`              |
| `SSH_KEY_SIZE`             | `4096`            |
| `SSH_KEY_ALGO`             | `rsa`             |
| `ENGINE_INSECURE_REGISTRY` | `queenshive:5000` |

## TODO

* define SSH Key Path
* build provision container on arm
* setup insecure registry
* setup tls docker engine
