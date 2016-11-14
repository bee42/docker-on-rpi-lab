node-exporter
=============

# Build Image

```bash
docker build -t bee42/node-exporter .
```

# Run Image 

```bash
docker run -d -p 9100:9100 --net="host" bee42/node-exporter
```