FROM bee42/rpi-golang:1.7

RUN mkdir -p /go/src/app
WORKDIR /go/src/app

CMD ["go-wrapper", "run"]

COPY . /go/src/app
RUN go get -v -d
RUN go install -v
