FROM golang:1.23 AS building

COPY . /building
WORKDIR /building

RUN make frps

FROM alpine:3

RUN apk add --no-cache tzdata

COPY --from=building /building/bin/frps /usr/bin/frps

ENTRYPOINT ["/usr/bin/frps"]

CMD ["-c", "/etc/frp/frps.toml"]