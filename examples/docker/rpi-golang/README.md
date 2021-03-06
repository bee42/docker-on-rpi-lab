# Build golang apps at your Docker on ARM setup

A programming language to build simple, reliable and efficient Software.

![](golang-logo.png)

Created by Robert Griesmer, Rob Pike and Ken Thompson and open sourced at november 2009.

![](golang-designer.png)

* https://golang.org/
* https://en.wikipedia.org/wiki/Go_(programming_language)
* http://www.slideshare.net/TeamHypriot/simplify-go-software-development-with-docker-58732126

## Create the golang tool container

```
$ docker -t bee42/rpi-golang -t bee42/rpi-golang:1.7 .
```

TODO

* check with external github libs
* describe alias hack
* check go-wrapper
  * https://github.com/docker-library/golang/blob/master/go-wrapper

```
$ docker -f Dockerfile.onbuild \
 -t bee42/rpi-golang:onbuild \
 -t bee42/rpi-golang:1.7-onbuild .
```

## Usage

see [golang](https://hub.docker.com/_/golang/)

## Example: google-get

* https://blog.codeship.com/building-minimal-docker-containers-for-go-applications/


```
$ mkdir -p google-get
$ cd google-get
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
$ cp /etc/ssl/certs/ca-certificates.crt .
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
$ docker build -t google-get-scratch -f Dockerfile.scratch .
$ docker run --rm google-get-scratch
```

## Example: onbuild

The most straightforward way to use this image is to use a Go container as both the build and runtime environment. In your Dockerfile, writing something along the lines of the following will compile and run your project:

```
$ mkdir -p hello && cd hello
$ cat >Dockerfile <<EOF
FROM bee42/rpi-golang:1.7-onbuild
EOF
$ cat >hello.go <<EOF
package main
import "fmt"
func main() {
    fmt.Println("hello world")
}
EOF
```

This image includes multiple `ONBUILD` triggers which should cover most applications. The build will `COPY . /go/src/app`, `RUN go get -d -v`, and `RUN go install -v`.

This image also includes the `CMD ["app"]` instruction which is the default command when running the image without arguments.

You can then build and run the Docker image:

```
$ docker build -t my-hello .
$ docker run -it --rm my-hello
```

__Note__: the default command in `bee42/rpi-golang:onbuild` is actually `go-wrapper` run, which includes `set -x` so the binary name is printed to stderr on application startup. If this behavior is undesirable, then adding `CMD ["app"]` (or `CMD ["myapp"]`` if a Go custom import path is in use will silence it by running the built binary directly.

## More Examples from others

* https://tour.golang.org/welcome/1
* https://gobyexample.com/
* https://github.com/ardanlabs/gotraining/tree/master/courses
* https://blog.codeship.com/building-minimal-docker-containers-for-go-applications/

## Links

* https://github.com/golang/go/wiki/GoArm
* https://github.com/hypriot/golang-armbuilds
