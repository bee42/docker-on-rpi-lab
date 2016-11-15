# Build and run prometheus

* https://prometheus.io
* https://prometheus.io/download/

![](prometheus.png)

build a arm version

```
$ docker build -t bee42/rpi-prometheus .
$ docker run -d -p 9090:9090 -v $(pwd)/prometheus/:/prometheus bee42/rpi-prometheus
```

## Enable docker engine metrics via daemon.json

This requires docker **1.13.x** and experimental features.

1. vi `/etc/docker/daemon.json`
2. Enable Experimental feature in `/etc/docker/daemon.json`
```
{
  "experimental":true
}
```
3. Add Metrics Address with port and IP
```
{
  "experimental":true,
  "metrics-addr":"0.0.0.0:5050"
}
```

With `0.0.0.0` the endpoint is on every interface available where the engine runs. For destrictive Address look in the example below.


## Access docker engine 1.13.x metrics

set metrics-addr and start with experimental features

```
$ vi /etc/docker/daemon.json
{
 "experimental": true,
 "storage-driver": "overlay",
 "insecure-registries": ["127.0.0.1:5000"],
 "metrics-addr": "127.0.0.1:5050"
}
$ systemctl restart docker.service
$ curl 127.0.0.1:5050/metrics
```

## Setup monitoring applications for all docker swarming nodes

The prometheus and grafana backend is working at your mac.
Add your mac to the swarming pi cluster

Create an monitoring network at your manager node

```
$ docker network create --driver overlay monitoring
```

set at any pi a machine label


`/etc/docker/daemon.json`

```
{
 "labels": [  "com.bee42.machine=rpi"  ]
}


starts at every node cadvisor to access container metrics

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
  --constraint 'node.labels.com.bee42.machine == rpi' \
  bee42/rpi-cadvisor
```

starts at every node node_exporter to access host metrics

```
$ docker service create --mode global \
  --name node-exporter \
  --network monitoring \
  --publish 9100 \
  --constraint 'node.labels.com.bee42.machine == rpi' \
  bee42/rpi-node-exporter
```

## Add monitoring infra containers only to to specific machines

/etc/docker/daemon.json

```
{
 "labels": [  "com.bee42.machine=main-monitor"  ]
}
```

lable your mac

```
$ docker node update --label-add com.bee42.machine=main-monitor <MachineName>
```

The following services will be deployed with constraints so that it will be placed on the correct nodes.

```
$ docker service create \
  --name prometheus \
  --network monitoring \
  --publish 9090:9090 \
  --constraint 'node.labels.com.bee42.machine == main-monitor' \
   prom/prometheus
```

ToDo: prometheus.config
* https://github.com/prometheus/prometheus/issues/1766

```
- job_name: 'cadvisor'
   dns_sd_configs:
   - names:
     - 'tasks.cadvisor'
     type: 'A'
     port: 8080

 - job_name: 'node-exporter'
   dns_sd_configs:
   - names:
     - 'tasks.node-exporter'
     type: 'A'
     port: 9100
```

```
$ docker service create \
  --name grafana \
  --network monitoring \
  --publish 3000:3000 \
   --constraint 'node.labels.com.bee42.machine == main-monitor' \
  -e "GF_SERVER_ROOT_URL=http://grafana.example.com" \
  -e "GF_SECURITY_ADMIN_PASSWORD=ADMINPASS" \
  -e "PROMETHEUS_ENDPOINT=http://prometheus:9090" \
  grafana/grafana
```

## Create a grafana dashboard

* https://github.com/grafana/grafana-docker
* https://grafana.net/dashboards/179
* https://grafana.net/dashboards?search=docker

## Other mointoring for one pi!

* http://rpi-experiences.blogspot.de/p/rpi-monitor.html
* https://github.com/XavierBerger/RPi-Monitor-deb


Regards
Niclas & Peter
