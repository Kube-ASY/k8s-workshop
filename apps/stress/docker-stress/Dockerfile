FROM ubuntu:20.04

RUN apt-get update && \
  DEBIAN_FRONTEND=noninteractive apt-get -y upgrade  && \
  DEBIAN_FRONTEND=noninteractive apt-get -y install --no-install-recommends stress dumb-init && \
  rm -rf /var/lib/apt/lists/*

ENTRYPOINT ["/usr/bin/dumb-init", "--"]
CMD ["/usr/bin/stress","--verbose"]