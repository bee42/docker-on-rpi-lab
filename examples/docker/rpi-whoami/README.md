# whoami

## Requirements
* ARM Board
* Docker

# Build Image

```bash
docker build -t bee42/whoa-build -f Dockerfile.build .
```
After this image is finish build your runtime image

```
docker build -t bee42/whoami .
```
* Build with go container
  * https://hub.docker.com/r/hypriot/rpi-golang/
  * https://blog.codeship.com/building-minimal-docker-containers-for-go-applications/
  * https://blog.golang.org/docker
* Package resuling binary

## Links

* https://github.com/emilevauge/whoamI

