# Build traefik

* https://traefik.io

```
$ docker build -t bee42/rpi-traefik .
$ docker run -d -p 8080:8080 -p 80:80 \
  -v /var/run/docker.sock:/var/run/docker.sock \
  bee42/rpi-traefik
```

```
$ docker-compose up -d
$ curl --header 'Host: whoami.docker.localhost' 'http://localhost:80/'
```

