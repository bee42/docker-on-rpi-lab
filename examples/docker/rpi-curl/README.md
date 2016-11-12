# curl for rpi

```
$ docker build -t bee42/rpi-curl .
```

```
$ docker run -ti -v /var/run/docker.sock:/var/run/docker.sock bee42/rpi-curl sh
> curl --unix-socket /var/run/docker.sock http:/containers/json
> exit
```

## Links

* https://nathanleclaire.com/blog/2015/11/12/using-curl-and-the-unix-socket-to-talk-to-the-docker-api/

