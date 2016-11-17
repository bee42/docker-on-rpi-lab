FROM armhf/alpine:3.4

ENV NODE_VERSION=4.6.0-r0

RUN apk update \
    && apk add ca-certificates nodejs-lts=$NODE_VERSION

CMD ["node"]
