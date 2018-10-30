FROM phusion/baseimage:0.9.11
MAINTAINER <support@sim-labs.com>

# Install Hamachi
ADD https://www.vpn.net/installers/logmein-hamachi-2.1.0.198-x64.tgz /tmp/hamachi.tgz
RUN mkdir -p /opt/logmein-hamachi \
  && tar -zxf /tmp/hamachi.tgz --strip-components 1 -C /opt/logmein-hamachi \
  && ln -sf /opt/logmein-hamachi/hamachid /usr/bin/hamachi \
  && rm /tmp/hamachi.tgz \
  && rm -rf /etc/service/{cron,sshd}

# Add install.sh to execute during container startup
COPY install.sh /etc/my_init.d/install.sh
# Add hamachi.sh to runit
COPY hamachi.sh /etc/service/hamachi/run

# persist config files
VOLUME /config

# Set correct environment variables
ENV HOME=/root
ENV HAMACHI_LOGIN=""
ENV HAMACHI_PASSWORD=""

# Use baseimage-docker's init system
CMD ["/sbin/my_init"]