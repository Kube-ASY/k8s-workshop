# Container to build stress
FROM golang:1.15 AS builder

LABEL maintainer="vishnuk@google.com"

WORKDIR /

COPY main.go /.

RUN GOBIN=/ go get

RUN GOBIN=/ CGO_ENABLED=0 go build --ldflags '-extldflags "-static"' -o stress

# Container to publish
FROM scratch

LABEL maintainer="vishnuk@google.com"

COPY --from=builder  /stress /

ENTRYPOINT ["/stress", "-logtostderr"]
