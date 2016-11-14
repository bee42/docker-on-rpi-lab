FROM scratch
COPY certs/ca-certificates.crt /etc/ssl/certs/
COPY traefik_linux-arm /
EXPOSE 80
ENTRYPOINT ["/traefik_linux-arm"]
