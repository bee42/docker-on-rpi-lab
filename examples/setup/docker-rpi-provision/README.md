rpi-provision 
=============

# Quickstart

1. Clone the Repository and switch to it.

2. docker-compose build

3. Edit rpi-provision.env like you want .

4. docker-compose run --rm rpi-provision

5. sudo ln -s  $(pwd)/config /machine

6. docker-machine --storage-path=$(pwd)/config/.docker-machine  ls

7. Connect via SSH 

```bash
docker-machine --storage-path=$(pwd)/config/.docker-machine  ssh bee42-crew-xx-xx
```

8. Connect to Engine

```bash
docker-machine --storage-path=$(pwd)/config/.docker-machine  env bee42-crew-xx-xxx
```
#WIP AREA

# Configuration Parameters
| Parameter | Description |
|-----------|-------------|
| `CREW_NUMBER` | |
| `MACHINE_ID` |  |
| `CONFIG_PATH` |  |
| `STORAGE_PATH` |  |
| `SSH_KEY_PATH` |  |
| `SSH_PORT` |  |
| `SSH_KEY_SIZE` |  Defaults to `4096`|
| `SSH_KEY_ALGO` | Defaults to `rsa`|


# TODO

#SSH Key Path festlegen

Insecure Registry eintragen


