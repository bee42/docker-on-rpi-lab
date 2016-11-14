# Build Prometheus

* https://prometheus.io
* https://prometheus.io/download/

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
3. Add Metrics Adress with port and IP
```
{
  "experimental":true,
  "metrics-addr":"0.0.0.0:5050"
}
```

With `0.0.0.0` the endpoint is on every interface available where the engine runs. For Restrictive Address look in the example below.


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

next

* Setup with prometheus
* Create a grafana dashboard


# Setup monitoring applications for all nodes

```
docker network create --driver overlay monitoring
````

```
docker \
  service create --mode global \
  --name cadvisor \
  --network monitoring \
  --publish 8080 \
  --mount type=bind,src=/,dst=/rootfs:ro \
  --mount type=bind,src=/var/run,dst=/var/run:rw \
  --mount type=bind,src=/sys,dst=/sys:ro \
  --mount type=bind,src=/var/lib/docker/,dst=/var/lib/docker:ro \
  bee42/cadvisor
````

```
docker service create --mode global \
  --name node-exporter \
  --network monitoring \
  --publish 9100 \
  bee42/node-exporter
```

# Add monitoring containers only to to specific machines

```
docker node update --label-add machine=main-monitor <MachineName>
```

The following services will be deployed with constraints so that it will be placed on the correct nodes .

```
docker service create \
  --name prometheus \
  --network monitoring \
  --publish 9090:9090 \
  --constraint 'node.labels.machine == main-monitor' \
   prom/prometheus
```


```
docker service create \
  --name grafana \
  --network monitoring \
  --publish 3000:3000 \
   --constraint 'node.labels.machine == main-monitor' \
  -e "GF_SERVER_ROOT_URL=http://grafana.example.com" \
  -e "GF_SECURITY_ADMIN_PASSWORD=ADMINPASS" \
  -e "PROMETHEUS_ENDPOINT=http://prometheus:9090" \
  grafana/grafana
```