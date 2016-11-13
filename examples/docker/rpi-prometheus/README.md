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
