#!/bin/bash

REPO=${REPO:-whoami}
CGO_ENABLED=${CGO_ENABLED:-0}
GOARCH=${GOARCH:-armv7}


git clone --depth 1 https://github.com/emilevauge/whoamI.git $REPO

cd $REPO || exit

go build -a --installsuffix cgo --ldflags="-s" -o whoamI

docker build -t bee42/whoami .

