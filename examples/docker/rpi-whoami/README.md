# whoami

## Requirements
* ARM Board
* Docker
* [rpi-golang](https://github.com/bee42/docker-on-rpi-lab/tree/master/examples/docker/rpi-golang)

# Build Image

```bash
$ ./build.sh
```
After this image is finish build your runtime image

# Run Image
```
$ docker run -P -d bee42/rpi-whoami
```
* Build with go container
  * https://hub.docker.com/r/hypriot/rpi-golang/
  * https://blog.codeship.com/building-minimal-docker-containers-for-go-applications/
  * https://blog.golang.org/docker
* Package resuling binary

## Links

* https://github.com/emilevauge/whoamI
