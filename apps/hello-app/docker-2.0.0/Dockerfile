FROM golang:1.17-alpine
WORKDIR /go/src/hello-app
COPY . .
RUN go get -d -v ./...
RUN go install -v ./...

FROM alpine:latest
COPY --from=0 /go/bin/hello-app .
ENV PORT 8080
CMD ["./hello-app"]
