# Build Prometheus

* https://prometheus.io
* https://prometheus.io/download/

```
$ docker build -t bee42/rpi-prometheus .
$ docker run -d -p 9090:9090 -v $(pwd)/prometheus/:/prometheus bee42/rpi-prometheus
```
