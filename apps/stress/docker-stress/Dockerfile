FROM ubuntu:20.04

RUN apt-get update && apt-get install -y stress

ENTRYPOINT ["/usr/bin/stress", "--verbose"]
CMD []