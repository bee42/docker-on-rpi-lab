# whoami

## Requirements
* ARM Board
* Docker

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
