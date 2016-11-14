rpi-traefik
==========

# How to use 

```
docker run -it --rm -p 8080:80  -v $(pwd)/traefik.toml:/etc/traefik/traefik.toml bee42/traefik
```

# Build Image by your own 

```bash
docker build -t bee42/traefik
```
