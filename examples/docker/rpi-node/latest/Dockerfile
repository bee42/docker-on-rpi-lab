FROM armhf/alpine:3.4

ENV NODE_VERSION=6.2.0-r0

RUN apk update \
    && apk add ca-certificates nodejs=$NODE_VERSION

ENTRYPOINT ["node"]