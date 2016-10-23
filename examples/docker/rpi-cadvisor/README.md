rpi-cadivsor
============

## Requirements
* ARM Board
* Docker

# Build Image

```bash
docker build -t bee42/cadivsor-build
```

After this image is finish build your runtime image

```
docker build -t bee42/cadvisor .
```
# Run Image

```bash
docker run \
  --volume=/:/rootfs:ro \
  --volume=/var/run:/var/run:rw \
  --volume=/sys:/sys:ro \
  --volume=/var/lib/docker/:/var/lib/docker:ro \
  --publish=8080:8080 \
  --detach=true \
  --name=cadvisor \
  bee42/cadvisor
```