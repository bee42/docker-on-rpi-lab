FROM scratch

COPY output/registry /
COPY config.yml /etc/docker/registry/config.yml

VOLUME ["/var/lib/registry"]
ENTRYPOINT ["/registry"]
CMD ["serve", "/etc/docker/registry/config.yml"]
