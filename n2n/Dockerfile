FROM ubuntu:xenial
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER <support@sim-labs.com>
RUN apt-get update && apt-get install -y \
    n2n \
    net-tools \
    && rm -rf /var/lib/apt/lists/*