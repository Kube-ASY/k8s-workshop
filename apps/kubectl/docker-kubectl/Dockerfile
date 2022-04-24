FROM alpine:20220328

USER root
RUN apk -U add git curl

ENV VERSION_KUBECTL=v1.20.10

## kubectl
RUN curl --create-dirs -sSLo /usr/local/bin/kubectl https://storage.googleapis.com/kubernetes-release/release/${VERSION_KUBECTL}/bin/linux/amd64/kubectl && chmod +x /usr/local/bin/kubectl

USER ${user}