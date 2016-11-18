# notepad start monitoring backplane

connect your mac to your pi docker swarm

```
$ screen ~/Library/Containers/com.docker.docker/Data/com.docker.driver.amd64-linux/tty
$ vi /etc/docker/daemon.json
{
  labels: [ "machine=mac" ]
}
$ kill -s HUP <pid docker>
$ docker info
$ docker swarm join "<token>" "<addr>"
```

## Start cadvisor and node-exporter with constraints `>=1.13.x`

* let manager select the published port?

```
$ docker \
  service create --mode global \
  --name cadvisor \
  --network monitoring \
  --publish 8080 \
  --mount type=bind,src=/,dst=/rootfs:ro \
  --mount type=bind,src=/var/run,dst=/var/run:rw \
  --mount type=bind,src=/sys,dst=/sys:ro \
  --mount type=bind,src=/var/lib/docker/,dst=/var/lib/docker:ro \
  --constraint 'node.labels.machine == rpi3' \
  queenshive:5000/bee42/rpi-cadvisor
$ docker service create --mode global \
  --name node-exporter \
  --network monitoring \
  --publish 9100 \
  --constraint 'node.labels.machine == rpi3' \
  queenshive:5000/bee42/rpi-node-exporter
```

* Setup prom config
* Missing: grafana dashboard config
* setup your password

```
docker service create \
  --name prometheus \
  --network monitoring \
  --publish 9090:9090 \
  --constraint 'node.hostname == moby' \
   prom/prometheus

$ docker service create \
 --name grafana \
 --network monitoring \
 --publish 3000:3000 \
  --constraint 'node.hostname == moby' \
 -e "GF_SERVER_ROOT_URL=http://localhost \
 -e "GF_SECURITY_ADMIN_PASSWORD=ADMINPASS" \
 -e "PROMETHEUS_ENDPOINT=http://prometheus:9090" \
 grafana/grafana
```

## Start cadvisor and node-exporter `1.12.x`

```
$ docker service create --mode global \
  --name node-exporter \
  --network monitoring \
  --publish 9100 \
  queenshive:5000/bee42/rpi-node-exporter

$ docker \
  service create --mode global \
  --name cadvisor \
  --network monitoring \
  --publish 8080 \
  --mount type=bind,src=/,dst=/rootfs:ro \
  --mount type=bind,src=/var/run,dst=/var/run:rw \
  --mount type=bind,src=/sys,dst=/sys:ro \
  --mount type=bind,src=/var/lib/docker/,dst=/var/lib/docker:ro \
  queenshive:5000/bee42/rpi-cadvisor
```
