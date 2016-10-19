# docker-on-rpi-lab

![](images/ship-container-with-a-bee.png =250x250)

## Aufbau des Labs - beehive

![](images/docker-swarming-at-pi.jpg)

## Einkaufswagen füllen, bestellen, bezahlen, installieren und Spaß haben!

Alle Komponenten die Ihr braucht um einen Docker ARM Cluster aufzubauen können in der Regel preiswert und zuverlässig bestellt werden. Wir haben uns an der Liste von [Roland Huss](https://ro14nd.de/kubernetes-on-raspberry-pi3) orientiert:

Danke Roland :-)

Unser Ziel ist es eine möglichst einfache Aufbau eines Raspberry-Pi-3 Cluster für Docker 1.12.x mit __swarming mode__ bereitzustellen.

Stand 2016-10. ca. 232 Euro

| Anzahl | Teil                                                         | Preis      |
|:-------|:-------------------------------------------------------------|:-----------|
| 3      | [Raspberry Pi 3](http://www.watterott.com/de/Raspberry-Pi-3) | 3 * 38 EUR |
| 3      | [Micro SD Card 32 GB](http://www.amazon.de/dp/B013UDL5RU)    | 3 * 11 EUR |
| 1      | [WLAN Router](http://www.amazon.de/dp/B00XPUIDFQ)            | 22 EUR     |
| 4      | [USB Kabel](http://www.amazon.de/dp/B016BEVNK4)              | 9 EUR      |
| 1      | [USB Stromgerät](http://www.amazon.de/dp/B00PTLSH9G)         | 30 EUR     |
| 1      | [Gehäuse](http://www.amazon.de/dp/B00NB1WPEE)                | 10 EUR     |
| 2      | [Zwischenplatten](http://www.amazon.de/dp/B00NB1WQZW)        | 2 * 7 EUR  |


## SD Karten für den Cluster vorbereiten

Es gibt mehrere Möglichkeiten ein RPi-Image auf eine SD-Karte zu bekommen. Wir nutzen für diesen Anwendungsfall das [Flash Tool der Hypriot Priraten](https://github.com/hypriot/flash). Als Basis der Installation verwenden wir das aktuelle [Hypriot OS](https://github.com/hypriot/image-builder-rpi/).

### Installation des Werkzeuges Flash unter Linux / OS X

Mit folgendem Befehlen installiert Ihr das Flash Tool:

```
$ curl -O https://raw.githubusercontent.com/hypriot/flash/master/$(uname -s)/flash && \
$ chmod +x flash && \
$ sudo mv flash /usr/local/bin/flash
```

### Download des Hypriot OS-Images

Download des Images:

```bash
$ mkdir OS-Images
$ cd OS-Images
$ HOS_VERSION=1.1.0
$ HOS_URL=https://github.com/hypriot/image-builder-rpi/releases/download
$ curl -LO ${HOS_URL}/v${HOS_VERSION}hypriotos-rpi-v${HOS_VERSION}.img.zip
```

Entpacken des Images:

```bash
unzip hypriotos-rpi-v1.1.0.img.zip
```

### Erstellen der Konfiguration `device_init.yaml`

Hier ist eine Beispiel für eine `device_init.yaml`:


```yml
hostname: "black-pearl"
wifi:
  interfaces:
    wlan0:
      ssid: "MyNetwork"
      password: "secret_password"
```

**Bitte** die Änderung des Hostnames und der Zugangsdaten des Routers (SSID und password) vornehmen.

Damit könnt Ihr nun in Euerer Umgebung den RPi prägen und dann einfach ausprobieren.

### Flashen des OS-Images

Nach Erstellung der Datei `device_init.yaml` könnt Ihr diese direkt mit auf die SD-Karte flashen. Ansonsten könnt ihr auch nach des Flashes die `device_init.yaml` direkt auf dem PI bearbeiten.

```bash
$ flash -c device_init.yaml hypriotos-rpi-v1.1.0.img
```

## Raspberry-Pi starten

Nach dem Einsetzen der Karten könnt Ihr den Raspberry-PI starten. Wenn alles geklappt sollte dieser mit dem WLAN verbunden sein. Nun könnt Ihr Euch mit dem PI per SSH verbinden.

```bash
$ssh pirate@<ip>
```

__Frage__: Wie bekommt heraus welche IP dem PI zugeordnet wurde?

Das Passwort für den User pirate lautet: **Hypriot**. Nun ist Euer PI für die Orchestrierung mit einem Docker Swarm Clusters bereit.

Ob Docker überhaupt korrekt installiert ist, könnt Ihr folgendermassen testen:

```bash
$ docker info
```

## Docker Engines der Pi's auf dem Mac verfügbar machen

* Mehrere PI's mit Machine Remote verfügbar machen
* https://github.com/docker/machine/pull/3605#issuecomment-239624969

```
#!/bin/sh
set -x

# access the Raspberry Pi running Raspbian/Jessie
IPADDRESS=192.168.2.115
PI_USERNAME=pi
PI_PASSWORD=raspberry

# deploy a Docker 1.12.1 on ARMv6 or ARMv7 Raspbian/Jessie
docker-machine --debug create \
  --driver=generic \
  --generic-ip-address=$IPADDRESS \
  --generic-ssh-user=$PI_USERNAME \
  --engine-install-url=https://get.docker.com/ \
  pi
```

### Zertifikate herunterladen und Remote nutzen

* mit scp von allen Pi in einer Schleife alle Certs besorgen.
* Kleiner Datei baum

```
$ mkdir beehive/<host>/
$ scp ca.pem|cert.pem|key.pem
```

* Beispiel des Zugriffs mit alias in der shell

```
# Configures the path to the ca.pem, cert.pem, and key.pem files used for TLS verification. Defaults to ~/.docker.
$ DOCKER_CERT_PATH=
# Sets the URL of the docker daemon. As with the Docker client, defaults to unix:///var/run/docker.sock.
$ DOCKER_HOST=
$ DOCKER_TLS_VERIFY=1
$ docker info
```

### ARM based Docker Machine

Das gibt es bei Hypriot in der Package-Cloud:
https://packagecloud.io/Hypriot/Schatzkiste/packages/debian/jessie/docker-machine_0.8.2-36_armhf.deb

Dann noch den Fix auf den Pi’s ausführen:
https://github.com/DieterReuter/arm-docker-fixes/tree/master/001-fix-docker-machine-1.8.0-create-for-arm

## Router konfigurieren

* s.h Rolands Pi Konfig
* Bilder und Screenshots

# Docker Swarming

Was ist das?

## Cluster initiieren

```bash
$ docker swarm init
```

Nun erhalten wir zwei Tokens einen Manger und einen Worker Token. Manager haben die Kontrolle über den Cluster und Worker führen nur die eingehenden Aufgaben aus.

## Cluster Tokens sichtbar machen und rotieren lassen

Um die Tokens nachschauen zu können muss man in dem Cluster sein. Docker stellt eine Befehl zu Verfügung um Tokens sichtbar zu machen oder auch rotieren zu lasen.

```bash
$ docker swarm join-token [--rotate] (worker|manager)
```
## Einen Worker Node zum Cluster hinzufügen

```
$ docker swarm join --token "super-secret" ip:2377
```

## Beispiel für den Start eines Services

**TODO**

# Aufräumen des Host-Systems


## Entfernen von Flash

```bash
sudo rm /usr/local/bin/flash
```

## Entfernen der Zertifkate
