# build golang at arm

```
$ docker -t bee42/rpi-golang .
```

TODO

* check with external github libs
* describe alias hack

## Examples

* https://blog.codeship.com/building-minimal-docker-containers-for-go-applications/


```
$ mkdir -p example
$ cd example
$ cat >main.go <<EOF
package main

import (
    "fmt"
    "io/ioutil"
    "net/http"
    "os"
)

func main() {
    resp, err := http.Get("https://google.com")
    check(err)
    body, err := ioutil.ReadAll(resp.Body)
    check(err)
    fmt.Println(len(body))
}

func check(err error) {
    if err != nil {
        fmt.Println(err)
        os.Exit(1)
    }
}
EOF
```

Build a docker images from this.

```
$ cp  /etc/ssl/certs/ca-certificates.crt .
$ cat >Dockerfile.scratch <<EOF
FROM scratch
ADD ca-certificates.crt /etc/ssl/certs/
ADD main /
CMD ["/main"]
EOF
$ docker run --rm \
 -v `pwd`:/go \
 -e GOOS=linux -e CGO_ENABLED=0 \
 bee42/rpi-golang \
 go build -a -installsuffix cgo -ldflags="-s -w" -o main .
$ docker build -t examples-scratch -f Dockerfile.scratch .
$ docker run --rm examples-scratch
```

## links

* https://github.com/golang/go/wiki/GoArm
* https://github.com/hypriot/golang-armbuilds
